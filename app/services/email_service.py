"""
이메일 발송 서비스
"""
import os
import smtplib
import logging
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import List
from datetime import datetime
from jinja2 import Template

logger = logging.getLogger(__name__)


class EmailService:
    """SMTP를 사용한 이메일 발송 서비스"""
    
    def __init__(self):
        self.smtp_host = os.getenv('SMTP_HOST', 'smtp.gmail.com')
        self.smtp_port = int(os.getenv('SMTP_PORT', '587'))
        self.smtp_username = os.getenv('SMTP_USERNAME', '')
        self.smtp_password = os.getenv('SMTP_PASSWORD', '')
        self.smtp_from_email = os.getenv('SMTP_FROM_EMAIL', self.smtp_username)
        self.smtp_from_name = os.getenv('SMTP_FROM_NAME', 'Spring Water Notification')
        self.base_url = os.getenv('BASE_URL', 'http://localhost:8000')
        
        if not self.smtp_username or not self.smtp_password:
            logger.warning("SMTP credentials not configured. Email sending will fail.")
    
    def _create_smtp_connection(self):
        """SMTP 연결 생성"""
        try:
            server = smtplib.SMTP(self.smtp_host, self.smtp_port)
            server.starttls()
            server.login(self.smtp_username, self.smtp_password)
            return server
        except Exception as e:
            logger.error(f"SMTP connection failed: {e}")
            raise
    
    def send_email(self, to_email: str, subject: str, html_content: str) -> bool:
        """
        이메일 발송
        
        Args:
            to_email: 수신자 이메일
            subject: 이메일 제목
            html_content: HTML 이메일 본문
            
        Returns:
            bool: 발송 성공 여부
        """
        try:
            msg = MIMEMultipart('alternative')
            msg['Subject'] = subject
            msg['From'] = f"{self.smtp_from_name} <{self.smtp_from_email}>"
            msg['To'] = to_email
            
            # HTML 파트 추가
            html_part = MIMEText(html_content, 'html', 'utf-8')
            msg.attach(html_part)
            
            # 이메일 발송
            server = self._create_smtp_connection()
            server.sendmail(self.smtp_from_email, to_email, msg.as_string())
            server.quit()
            
            logger.info(f"Email sent successfully to {to_email}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to send email to {to_email}: {e}")
            return False
    
    def send_subscription_confirmation(self, email: str, token: str) -> bool:
        """
        구독 확인 이메일 발송
        
        Args:
            email: 구독자 이메일
            token: 구독 확인 토큰
            
        Returns:
            bool: 발송 성공 여부
        """
        confirmation_url = f"{self.base_url}/api/subscribe/confirm/{token}"
        
        html_content = self._get_subscription_confirmation_template(
            email=email,
            confirmation_url=confirmation_url,
            token=token
        )
        
        subject = "🔔 먹는샘물 위반 알림 구독 확인"
        return self.send_email(email, subject, html_content)
    
    def send_violation_alert(
        self,
        email: str,
        violations: List[dict],
        unsubscribe_token: str
    ) -> bool:
        """
        새로운 위반 알림 이메일 발송
        
        Args:
            email: 구독자 이메일
            violations: 새로운 위반 목록
            unsubscribe_token: 구독 취소 토큰
            
        Returns:
            bool: 발송 성공 여부
        """
        unsubscribe_url = f"{self.base_url}/api/unsubscribe/{unsubscribe_token}"
        
        html_content = self._get_violation_alert_template(
            violations=violations,
            unsubscribe_url=unsubscribe_url
        )
        
        subject = f"⚠️ 새로운 먹는샘물 위반 {len(violations)}건 발견"
        return self.send_email(email, subject, html_content)
    
    def send_welcome_email(self, email: str, unsubscribe_token: str) -> bool:
        """
        환영 이메일 발송 (구독 확인 감사)
        
        Args:
            email: 구독자 이메일
            unsubscribe_token: 구독 취소 토큰
            
        Returns:
            bool: 발송 성공 여부
        """
        unsubscribe_url = f"{self.base_url}/api/unsubscribe/{unsubscribe_token}"
        
        html_content = self._get_welcome_email_template(
            email=email,
            unsubscribe_url=unsubscribe_url
        )
        
        subject = "🎉 먹는샘물 위반 알림 구독을 환영합니다!"
        return self.send_email(email, subject, html_content)
    
    def _get_subscription_confirmation_template(
        self,
        email: str,
        confirmation_url: str,
        token: str
    ) -> str:
        """구독 확인 이메일 템플릿"""
        template = Template("""
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구독 확인</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif; background-color: #f5f5f5;">
    <div style="max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        <!-- 헤더 -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 20px; text-align: center;">
            <h1 style="color: #ffffff; margin: 0; font-size: 28px;">🔔 구독 확인</h1>
            <p style="color: #ffffff; margin: 10px 0 0 0; opacity: 0.9;">먹는샘물 위반 알림 서비스</p>
        </div>
        
        <!-- 본문 -->
        <div style="padding: 40px 30px;">
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 20px;">
                안녕하세요,<br>
                <strong>{{ email }}</strong> 주소로 구독 신청이 접수되었습니다.
            </p>
            
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 30px;">
                아래 버튼을 클릭하여 구독을 확인해주세요. 확인 후 새로운 먹는샘물 위반 사례가 발견될 때마다 즉시 알림을 받으실 수 있습니다.
            </p>
            
            <!-- 버튼 -->
            <div style="text-align: center; margin: 40px 0;">
                <a href="https://spring-water-notification-web.vercel.app/?confirm={{ token }}" 
                   style="display: inline-block; padding: 16px 40px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #ffffff; text-decoration: none; border-radius: 50px; font-size: 16px; font-weight: bold; box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);">
                    구독 확인하기
                </a>
            </div>
            
            <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 30px;">
                <p style="font-size: 14px; color: #666666; margin: 0; line-height: 1.6;">
                    💡 <strong>알림 내용:</strong><br>
                    • 새로운 먹는샘물 위반 회사 정보<br>
                    • 처분명 및 위반 내용<br>
                    • 공표 기간 정보
                </p>
            </div>
        </div>
        
        <!-- 푸터 -->
        <div style="background-color: #f8f9fa; padding: 30px; text-align: center; border-top: 1px solid #e9ecef;">
            <p style="font-size: 12px; color: #999999; margin: 0; line-height: 1.6;">
                본 이메일은 요청에 의해 발송되었습니다.<br>
                구독을 원하지 않으시면 이 이메일을 무시하시면 됩니다.
            </p>
        </div>
    </div>
</body>
</html>
        """)
        
        return template.render(
            email=email,
            confirmation_url=confirmation_url,
            token=token
        )
    
    def _get_violation_alert_template(
        self,
        violations: List[dict],
        unsubscribe_url: str
    ) -> str:
        """위반 알림 이메일 템플릿"""
        template = Template("""
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새로운 위반 알림</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif; background-color: #f5f5f5;">
    <div style="max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        <!-- 헤더 -->
        <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 40px 20px; text-align: center;">
            <h1 style="color: #ffffff; margin: 0; font-size: 28px;">⚠️ 새로운 위반 발견</h1>
            <p style="color: #ffffff; margin: 10px 0 0 0; opacity: 0.9;">먹는샘물 위반 알림 서비스</p>
        </div>
        
        <!-- 본문 -->
        <div style="padding: 40px 30px;">
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 20px;">
                새로운 먹는샘물 위반 사례 <strong>{{ violations|length }}건</strong>이 발견되었습니다.
            </p>
            
            <div style="margin: 30px 0;">
                {% for violation in violations %}
                <div style="background-color: #fff5f5; border-left: 4px solid #f5576c; padding: 20px; margin-bottom: 20px; border-radius: 4px;">
                    <h3 style="margin: 0 0 10px 0; color: #d63031; font-size: 18px;">{{ violation.업체명 }}</h3>
                    
                    <div style="margin: 15px 0;">
                        <div style="margin-bottom: 8px;">
                            <span style="display: inline-block; background-color: #fff; padding: 4px 12px; border-radius: 12px; font-size: 12px; color: #666; margin-right: 8px;">
                                📦 {{ violation.제품명 or '제품명 미상' }}
                            </span>
                            <span style="display: inline-block; background-color: #fff; padding: 4px 12px; border-radius: 12px; font-size: 12px; color: #666;">
                                📍 {{ violation.업체소재지 or '소재지 미상' }}
                            </span>
                        </div>
                    </div>
                    
                    <div style="background-color: #ffffff; padding: 15px; border-radius: 4px; margin-top: 15px;">
                        <p style="margin: 0 0 10px 0; font-size: 14px; color: #666;">
                            <strong style="color: #333;">처분명:</strong> {{ violation.처분명 }}
                        </p>
                        <p style="margin: 0 0 10px 0; font-size: 14px; color: #666;">
                            <strong style="color: #333;">처분일자:</strong> {{ violation.처분일자 }}
                        </p>
                        <p style="margin: 0 0 10px 0; font-size: 14px; color: #666;">
                            <strong style="color: #333;">공표마감일:</strong> {{ violation.공표마감일자 }}
                        </p>
                        <p style="margin: 0; font-size: 14px; color: #666;">
                            <strong style="color: #333;">위반내용:</strong><br>
                            <span style="color: #999; font-size: 13px;">{{ violation.위반내용[:200] }}{% if violation.위반내용|length > 200 %}...{% endif %}</span>
                        </p>
                    </div>
                    
                    {% if violation.상세URL %}
                    <div style="margin-top: 15px;">
                        <a href="{{ violation.상세URL }}" 
                           style="display: inline-block; padding: 8px 16px; background-color: #667eea; color: #ffffff; text-decoration: none; border-radius: 4px; font-size: 13px;">
                            자세히 보기 →
                        </a>
                    </div>
                    {% endif %}
                </div>
                {% endfor %}
            </div>
            
            <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 30px;">
                <p style="font-size: 14px; color: #666666; margin: 0; line-height: 1.6;">
                    💡 새로운 위반이 발견될 때마다 즉시 알림을 보내드립니다.<br>
                    안전한 먹는물을 위해 항상 최신 정보를 확인하세요.
                </p>
            </div>
        </div>
        
        <!-- 푸터 -->
        <div style="background-color: #f8f9fa; padding: 30px; text-align: center; border-top: 1px solid #e9ecef;">
            <p style="font-size: 12px; color: #999999; margin: 0 0 10px 0;">
                이 알림이 더 이상 필요하지 않으신가요?
            </p>
            <a href="{{ unsubscribe_url }}" 
               style="font-size: 12px; color: #667eea; text-decoration: none;">
                구독 취소하기
            </a>
        </div>
    </div>
</body>
</html>
        """)
        
        return template.render(
            violations=violations,
            unsubscribe_url=unsubscribe_url
        )
    
    def _get_welcome_email_template(
        self,
        email: str,
        unsubscribe_url: str
    ) -> str:
        """환영 이메일 템플릿"""
        template = Template("""
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>환영합니다</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif; background-color: #f5f5f5;">
    <div style="max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        <!-- 헤더 -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 20px; text-align: center;">
            <h1 style="color: #ffffff; margin: 0; font-size: 28px;">🎉 환영합니다!</h1>
            <p style="color: #ffffff; margin: 10px 0 0 0; opacity: 0.9;">먹는샘물 위반 알림 서비스</p>
        </div>
        
        <!-- 본문 -->
        <div style="padding: 40px 30px;">
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 20px;">
                안녕하세요,<br>
                <strong>{{ email }}</strong> 님의 구독을 환영합니다!
            </p>
            
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 30px;">
                구독이 성공적으로 확인되었습니다. 이제부터 새로운 먹는샘물 위반 사례가 발견될 때마다 즉시 알림을 받으실 수 있습니다.
            </p>
            
            <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
                <p style="font-size: 14px; color: #666666; margin: 0 0 15px 0; line-height: 1.6;">
                    <strong style="color: #333;">📧 알림 내용:</strong>
                </p>
                <ul style="font-size: 14px; color: #666666; margin: 0; padding-left: 20px; line-height: 1.8;">
                    <li>새로운 먹는샘물 위반 회사 정보</li>
                    <li>처분명 및 위반 내용 상세</li>
                    <li>공표 기간 정보</li>
                    <li>관련 상세 링크</li>
                </ul>
            </div>
            
            <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 20px; border-radius: 8px; margin-bottom: 30px;">
                <p style="font-size: 14px; color: #ffffff; margin: 0; line-height: 1.6; text-align: center;">
                    ✨ 곧 현재 등록된 위반 정보를 담은<br>
                    별도의 이메일을 보내드리겠습니다!
                </p>
            </div>
            
            <p style="font-size: 14px; line-height: 1.6; color: #999999; margin-top: 30px;">
                안전한 먹는물을 위해 항상 최신 정보를 확인하세요.<br>
                감사합니다.
            </p>
        </div>
        
        <!-- 푸터 -->
        <div style="background-color: #f8f9fa; padding: 30px; text-align: center; border-top: 1px solid #e9ecef;">
            <p style="font-size: 12px; color: #999999; margin: 0 0 10px 0;">
                이 알림이 더 이상 필요하지 않으신가요?
            </p>
            <a href="{{ unsubscribe_url }}" 
               style="font-size: 12px; color: #667eea; text-decoration: none;">
                구독 취소하기
            </a>
        </div>
    </div>
</body>
</html>
        """)
        
        return template.render(
            email=email,
            unsubscribe_url=unsubscribe_url
        )


# 싱글톤 인스턴스
email_service = EmailService()

