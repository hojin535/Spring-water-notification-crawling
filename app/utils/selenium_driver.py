"""
Selenium WebDriver 설정 및 관리
"""
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from contextlib import contextmanager
import logging

logger = logging.getLogger(__name__)


def get_chrome_options() -> Options:
    """Chrome 옵션 설정"""
    chrome_options = Options()
    
    # Headless 모드 (브라우저 창을 띄우지 않음)
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument('--disable-gpu')
    
    # User agent 설정 (봇으로 감지되지 않도록)
    chrome_options.add_argument(
        'user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '
        'AppleWebKit/537.36 (KHTML, like Gecko) '
        'Chrome/120.0.0.0 Safari/537.36'
    )
    
    # 이미지 로딩 비활성화 (속도 향상)
    prefs = {
        'profile.managed_default_content_settings.images': 2,
        'profile.default_content_setting_values.notifications': 2,
    }
    chrome_options.add_experimental_option('prefs', prefs)
    
    # 로그 레벨 설정
    chrome_options.add_argument('--log-level=3')
    
    return chrome_options


def create_driver() -> webdriver.Chrome:
    """Chrome WebDriver 생성"""
    import os
    import stat
    
    try:
        chrome_options = get_chrome_options()
        
        # 1. Docker 환경 변수에서 chromedriver 경로 확인
        driver_path = os.getenv('CHROMEDRIVER_PATH')
        
        # 2. Docker에서 chromium 바이너리 경로 설정
        chrome_binary = os.getenv('CHROME_BIN')
        if chrome_binary and os.path.exists(chrome_binary):
            chrome_options.binary_location = chrome_binary
            logger.info(f"Using Chrome binary: {chrome_binary}")
        
        # 3. driver_path가 설정되어 있고 파일이 존재하면 사용 (Docker 환경)
        if driver_path and os.path.exists(driver_path):
            logger.info(f"Using system ChromeDriver from env: {driver_path}")
        else:
            # 4. 일반적인 시스템 경로 확인
            system_paths = [
                '/usr/bin/chromedriver',
                '/usr/local/bin/chromedriver',
            ]
            
            driver_path = None
            for path in system_paths:
                if os.path.exists(path):
                    driver_path = path
                    logger.info(f"Found system ChromeDriver: {driver_path}")
                    break
            
            # 5. 시스템에 없으면 ChromeDriverManager로 다운로드
            if not driver_path:
                logger.info("System ChromeDriver not found, downloading via ChromeDriverManager...")
                driver_path = ChromeDriverManager().install()
                logger.info(f"ChromeDriver path: {driver_path}")
                
                # 실행 가능한 chromedriver 파일 찾기
                if os.path.isdir(driver_path):
                    # 디렉토리인 경우 chromedriver 실행 파일 찾기
                    for root, dirs, files in os.walk(driver_path):
                        if 'chromedriver' in files:
                            driver_path = os.path.join(root, 'chromedriver')
                            break
                elif not os.path.basename(driver_path) == 'chromedriver':
                    # chromedriver가 아닌 파일인 경우 디렉토리에서 찾기
                    driver_dir = os.path.dirname(driver_path)
                    for root, dirs, files in os.walk(driver_dir):
                        if 'chromedriver' in files:
                            driver_path = os.path.join(root, 'chromedriver')
                            break
        
        # 실행 권한 확인 및 부여
        if os.path.exists(driver_path):
            current_permissions = os.stat(driver_path).st_mode
            # 실행 권한이 없으면 추가
            if not (current_permissions & stat.S_IXUSR):
                os.chmod(driver_path, current_permissions | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)
                logger.info(f"Set execute permissions for ChromeDriver")
        else:
            raise FileNotFoundError(f"ChromeDriver not found at {driver_path}")
        
        logger.info(f"Using ChromeDriver: {driver_path}")
        service = Service(driver_path)
        driver = webdriver.Chrome(service=service, options=chrome_options)
        driver.implicitly_wait(10)  # 암묵적 대기 시간 설정
        logger.info("Chrome WebDriver created successfully")
        return driver
    except Exception as e:
        logger.error(f"Failed to create Chrome WebDriver: {e}")
        raise


@contextmanager
def get_driver():
    """
    WebDriver 컨텍스트 매니저
    
    사용 예:
        with get_driver() as driver:
            driver.get('https://example.com')
            # 작업 수행
    """
    driver = None
    try:
        driver = create_driver()
        yield driver
    finally:
        if driver:
            driver.quit()
            logger.info("Chrome WebDriver closed")
