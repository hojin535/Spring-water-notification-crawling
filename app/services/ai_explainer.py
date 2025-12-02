"""
AI 기반 위반 내역 설명 생성 서비스
"""
import os
import hashlib
import json
from typing import Dict, List, Optional
from sqlalchemy.orm import Session
from sqlalchemy import func
import google.generativeai as genai
import logging

from app.db_models import WaterTerm, ViolationExplanationCache

logger = logging.getLogger(__name__)


class ViolationExplainer:
    """위반 내역을 AI를 활용하여 쉽게 설명하는 클래스"""
    
    def __init__(self):
        # Google API Key 설정
        api_key = os.getenv('GOOGLE_API_KEY')
        if not api_key:
            raise ValueError(
                "GOOGLE_API_KEY가 설정되지 않았습니다. "
                ".env 파일에 GOOGLE_API_KEY=your_key 를 추가해주세요."
            )
        
        genai.configure(api_key=api_key)
        # gemini-2.5-flash-lite: 최신 Gemini 2.5 모델의 경량화 버전 (빠르고 효율적)
        self.model = genai.GenerativeModel('gemini-2.5-flash-lite')
    
    def _generate_cache_key(self, 처분명: str, 위반내용: str) -> str:
        """
        처분명과 위반내용으로 캐시 키 생성 (SHA-256 해시)
        
        Args:
            처분명: 처분 명칭
            위반내용: 위반 내용
            
        Returns:
            64자 해시 문자열
        """
        combined = f"{처분명}|{위반내용}"
        return hashlib.sha256(combined.encode('utf-8')).hexdigest()
    
    def _get_cached_explanation(self, cache_key: str, db: Session) -> Optional[Dict]:
        """
        캐시된 설명 조회
        
        Args:
            cache_key: 캐시 키
            db: 데이터베이스 세션
            
        Returns:
            캐시된 설명 또는 None
        """
        cache = db.query(ViolationExplanationCache).filter(
            ViolationExplanationCache.cache_key == cache_key
        ).first()
        
        if cache:
            # 접근 횟수 및 시간 업데이트
            cache.access_count += 1
            cache.accessed_at = func.now()
            db.commit()
            
            logger.info(f"Cache HIT for key {cache_key[:8]}... (accessed {cache.access_count} times)")
            
            # JSON 파싱
            related_terms = json.loads(cache.related_terms_json) if cache.related_terms_json else []
            
            return {
                "easy_explanation": cache.easy_explanation,
                "related_terms": related_terms,
                "from_cache": True
            }
        
        logger.info(f"Cache MISS for key {cache_key[:8]}...")
        return None
    
    def _save_to_cache(
        self, 
        cache_key: str, 
        처분명: str, 
        위반내용: str, 
        easy_explanation: str, 
        related_terms: List[Dict],
        db: Session
    ):
        """
        설명을 캐시에 저장
        
        Args:
            cache_key: 캐시 키
            처분명: 처분 명칭
            위반내용: 위반 내용
            easy_explanation: AI 생성 설명
            related_terms: 관련 전문 용어 리스트
            db: 데이터베이스 세션
        """
        try:
            cache_entry = ViolationExplanationCache(
                cache_key=cache_key,
                처분명=처분명,
                위반내용=위반내용,
                easy_explanation=easy_explanation,
                related_terms_json=json.dumps(related_terms, ensure_ascii=False),
                access_count=1
            )
            db.add(cache_entry)
            db.commit()
            logger.info(f"Saved explanation to cache with key {cache_key[:8]}...")
        except Exception as e:
            db.rollback()
            logger.error(f"Failed to save to cache: {e}")
        
    def _extract_terms_from_text(self, text: str, db: Session) -> List[Dict]:
        """
        텍스트에서 DB에 등록된 전문 용어를 찾아서 반환
        
        Args:
            text: 검색할 텍스트
            db: 데이터베이스 세션
            
        Returns:
            발견된 전문 용어 리스트
        """
        # DB에서 모든 전문 용어 조회
        all_terms = db.query(WaterTerm).all()
        
        # 더 긴 용어부터 검색하도록 정렬 (예: "일반세균(저온)" 먼저, "일반세균" 나중에)
        all_terms = sorted(all_terms, key=lambda x: len(x.term), reverse=True)
        
        found_terms = []
        found_term_names = set()  # 중복 방지
        
        for term_obj in all_terms:
            # 이미 찾은 용어는 건너뛰기
            if term_obj.term in found_term_names:
                continue
                
            # 텍스트에 해당 용어가 포함되어 있는지 확인
            if term_obj.term in text:
                found_terms.append({
                    "term": term_obj.term,
                    "description": term_obj.description,
                    "category": term_obj.category,
                    "category_name": term_obj.category_name,
                    "risk_level": term_obj.risk_level
                })
                found_term_names.add(term_obj.term)
        
        logger.info(f"Found {len(found_terms)} related terms in text: {[t['term'] for t in found_terms]}")
        return found_terms
    
    def _create_prompt(self, 처분명: str, 위반내용: str, related_terms: List[Dict]) -> str:
        """
        Gemini API에 전달할 프롬프트 생성
        
        Args:
            처분명: 처분 명칭
            위반내용: 위반 내용
            related_terms: 관련 전문 용어 리스트
            
        Returns:
            생성된 프롬프트
        """
        # 전문 용어 설명을 프롬프트에 포함
        terms_context = ""
        if related_terms:
            terms_context = "\n\n참고할 전문 용어:\n"
            for term in related_terms:
                terms_context += f"- {term['term']}: {term['description']}\n"
        
        prompt = f"""다음은 먹는샘물(생수) 업체의 행정처분 내용입니다. 일반인이 이해하기 쉽게 설명해주세요.

처분명: {처분명}

위반내용:
{위반내용}
{terms_context}

요구사항:
- 3-5문장으로 간결하게 설명
- 전문 용어는 쉬운 말로 풀어서 설명
- 왜 문제인지, 건강에 어떤 영향이 있는지 간단히 언급
- 마크다운 문법(#, **, * 등) 사용하지 말고 일반 텍스트로만 작성
- 불필요한 서론이나 제목 없이 바로 핵심 설명만 작성

설명:"""

        return prompt
    
    async def explain_violation(
        self, 
        처분명: str, 
        위반내용: str, 
        db: Session
    ) -> Dict:
        """
        위반 내역을 AI로 쉽게 설명 (캐싱 지원)
        
        Args:
            처분명: 처분 명칭
            위반내용: 위반 내용
            db: 데이터베이스 세션
            
        Returns:
            {
                "easy_explanation": "일반인이 이해하기 쉬운 설명",
                "related_terms": [...],
                "from_cache": True/False  # 캐시에서 가져왔는지 여부
            }
        """
        try:
            # 1. 캐시 키 생성
            cache_key = self._generate_cache_key(처분명, 위반내용)
            
            # 2. 캐시 확인
            cached_result = self._get_cached_explanation(cache_key, db)
            if cached_result:
                return cached_result
            
            # 3. 캐시 미스 - DB에서 관련 전문 용어 찾기
            combined_text = f"{처분명}\n{위반내용}"
            related_terms = self._extract_terms_from_text(combined_text, db)
            
            # 4. AI 프롬프트 생성
            prompt = self._create_prompt(처분명, 위반내용, related_terms)
            
            # 5. Gemini API 호출
            logger.info("Calling Gemini API for explanation...")
            response = self.model.generate_content(prompt)
            
            if not response or not response.text:
                raise Exception("Gemini API returned empty response")
            
            explanation = response.text.strip()
            logger.info(f"Generated explanation: {explanation[:100]}...")
            
            # 6. 캐시에 저장
            self._save_to_cache(cache_key, 처분명, 위반내용, explanation, related_terms, db)
            
            return {
                "easy_explanation": explanation,
                "related_terms": related_terms,
                "from_cache": False
            }
            
        except Exception as e:
            logger.error(f"Error generating explanation: {e}", exc_info=True)
            raise Exception(f"AI 설명 생성 중 오류가 발생했습니다: {str(e)}")



# 싱글톤 인스턴스
_explainer_instance: Optional[ViolationExplainer] = None


def get_explainer() -> ViolationExplainer:
    """ViolationExplainer 싱글톤 인스턴스 반환"""
    global _explainer_instance
    
    if _explainer_instance is None:
        _explainer_instance = ViolationExplainer()
    
    return _explainer_instance
