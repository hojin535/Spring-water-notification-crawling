"""
MCEE (기후에너지환경부) 먹는물영업자 위반현황 크롤러
"""
from typing import List, Dict, Optional
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import logging
import time

from app.utils.selenium_driver import get_driver
from app.models.violation import ViolationListItem, ViolationDetail

logger = logging.getLogger(__name__)

BASE_URL = "https://www.mcee.go.kr"
LIST_URL = f"{BASE_URL}/home/web/index.do?menuId=10227"


def get_violation_list() -> List[Dict]:
    """
    메인 페이지에서 위반 목록 데이터 크롤링
    
    Returns:
        List[Dict]: 위반 목록 (순번, 품목, 업체명, 제품명, 처분명, 처분일자, 공표마감일자, 상세URL)
    """
    logger.info("Starting to crawl violation list")
    violations = []
    
    try:
        with get_driver() as driver:
            driver.get(LIST_URL)
            
            # 페이지 로딩 대기
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.TAG_NAME, "table"))
            )
            
            # 페이지 소스 가져오기
            page_source = driver.page_source
            soup = BeautifulSoup(page_source, 'lxml')
            
            # 테이블 찾기
            table = soup.find('table')
            if not table:
                logger.error("Table not found on the page")
                return violations
            
            # 데이터 행 찾기 (헤더가 아닌 실제 데이터 행)
            rows = table.find_all('tr')
            
            for row in rows:
                cells = row.find_all('td')
                
                # 데이터가 있는 행인지 확인 (최소 7개 셀)
                if len(cells) >= 7:
                    # 첫 번째 셀이 순번인지 확인
                    first_cell_text = cells[0].get_text(strip=True)
                    if first_cell_text.isdigit():
                        # 상세 페이지 URL 추출
                        detail_url = None
                        link = cells[1].find('a') or cells[2].find('a') or cells[4].find('a')
                        if link and link.get('href'):
                            href = link.get('href')
                            if href.startswith('/'):
                                detail_url = BASE_URL + href
                            elif href.startswith('http'):
                                detail_url = href
                            else:
                                detail_url = BASE_URL + '/' + href
                        
                        violation = {
                            "순번": cells[0].get_text(strip=True),
                            "품목": cells[1].get_text(strip=True),
                            "업체명": cells[2].get_text(strip=True),
                            "제품명": cells[3].get_text(strip=True),
                            "처분명": cells[4].get_text(strip=True),
                            "처분일자": cells[5].get_text(strip=True),
                            "공표마감일자": cells[6].get_text(strip=True),
                            "상세URL": detail_url
                        }
                        violations.append(violation)
                        logger.debug(f"Found violation: {violation['업체명']}")
            
            logger.info(f"Successfully crawled {len(violations)} violations from list")
            
    except Exception as e:
        logger.error(f"Error crawling violation list: {e}", exc_info=True)
        raise
    
    return violations


def get_violation_detail(url: str) -> Dict:
    """
    상세 페이지 데이터 크롤링
    
    Args:
        url: 상세 페이지 URL
        
    Returns:
        Dict: 상세 정보 (품목, 업체명, 업체소재지, 제품명, 업종명, 공표마감일자, 
                       처분명, 처분기간, 위반내용, 처분일자)
    """
    logger.info(f"Crawling detail page: {url}")
    detail_data = {}
    
    try:
        with get_driver() as driver:
            driver.get(url)
            
            # 페이지 로딩 대기
            time.sleep(1)
            
            # 페이지 소스 가져오기
            page_source = driver.page_source
            soup = BeautifulSoup(page_source, 'lxml')
            
            # dl/dt/dd 구조에서 데이터 추출
            dls = soup.find_all('dl')
            for dl in dls:
                dts = dl.find_all('dt')
                dds = dl.find_all('dd')
                
                for dt, dd in zip(dts, dds):
                    key = dt.get_text(strip=True)
                    value = dd.get_text(strip=True)
                    detail_data[key] = value
            
            # 위반내용 추출 (p 태그에서)
            violation_content_title = soup.find('p', class_='fw500', string=lambda text: text and '위반내용' in text)
            if violation_content_title and violation_content_title.find_next_sibling('p'):
                # separator='\n'를 사용하여 줄바꿈 유지
                violation_content = violation_content_title.find_next_sibling('p').get_text(separator='\n', strip=True)
                detail_data['위반내용'] = violation_content
            else:
                detail_data['위반내용'] = ""
                logger.warning(f"Violation content not found for URL: {url}")
            
            logger.info(f"Successfully crawled detail data")
            
    except Exception as e:
        logger.error(f"Error crawling detail page {url}: {e}", exc_info=True)
        raise
    
    return detail_data


def get_all_violations_with_details() -> List[Dict]:
    """
    목록 + 각 항목의 상세 정보를 모두 크롤링
    
    Returns:
        List[Dict]: 모든 상세 정보를 포함한 위반 목록
    """
    logger.info("Starting to crawl all violations with details")
    
    # 먼저 목록 가져오기
    violations_list = get_violation_list()
    
    detailed_violations = []
    
    for i, item in enumerate(violations_list, 1):
        logger.info(f"Processing {i}/{len(violations_list)}: {item['업체명']}")
        
        if item.get('상세URL'):
            try:
                # 상세 정보 가져오기
                detail = get_violation_detail(item['상세URL'])
                detailed_violations.append(detail)
                
                # 서버 부하 방지를 위한 대기
                if i < len(violations_list):
                    time.sleep(1)
                    
            except Exception as e:
                logger.error(f"Failed to get details for {item['업체명']}: {e}")
                # 오류가 발생해도 계속 진행
                continue
        else:
            logger.warning(f"No detail URL for item: {item['업체명']}")
    
    logger.info(f"Successfully crawled {len(detailed_violations)} detailed violations")
    return detailed_violations


def get_violation_by_board_id(board_id: str) -> Dict:
    """
    특정 board_id의 상세 정보 가져오기
    
    Args:
        board_id: 게시물 ID
        
    Returns:
        Dict: 상세 정보
    """
    url = (
        f"{BASE_URL}/home/web/waterViolationBusiness/read.do"
        f"?boardId={board_id}&boardMasterId=114&menuId=10227"
    )
    return get_violation_detail(url)
