"""
AI 설명 API용 Pydantic 모델
"""
from pydantic import BaseModel, Field
from typing import List


class ExplainRequest(BaseModel):
    """위반 내역 설명 요청"""
    처분명: str = Field(..., description="처분 명칭")
    위반내용: str = Field(..., description="위반 내용 상세")
    
    class Config:
        json_schema_extra = {
            "example": {
                "처분명": "자가품질검사 일부 미실시 등",
                "위반내용": "자가품질검사 일부 미실시\n무기물질 함량 표시기준을 위반한 먹는 샘물을 판매제조등 영업상 사용"
            }
        }


class TermExplanation(BaseModel):
    """전문 용어 설명"""
    term: str = Field(..., description="전문 용어")
    description: str = Field(..., description="쉬운 설명")
    category: str = Field(..., description="카테고리 (영문)")
    category_name: str = Field(..., description="카테고리 (한글)")
    risk_level: str = Field(..., description="위험도: high, medium, low")


class ExplainResponse(BaseModel):
    """위반 내역 설명 응답"""
    easy_explanation: str = Field(..., description="AI가 생성한 쉬운 설명")
    related_terms: List[TermExplanation] = Field(
        default_factory=list, 
        description="관련 전문 용어 리스트"
    )
    
    class Config:
        json_schema_extra = {
            "example": {
                "easy_explanation": "이 업체는 물의 품질을 정기적으로 검사해야 하는데 일부 검사를 하지 않았습니다...",
                "related_terms": [
                    {
                        "term": "총대장균군",
                        "description": "물이나 음식물의 위생 상태를 나타내는 지표 세균",
                        "category": "microorganism",
                        "category_name": "미생물",
                        "risk_level": "high"
                    }
                ]
            }
        }
