"""
이메일 구독 관련 Pydantic 모델
"""
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime


class SubscribeRequest(BaseModel):
    """이메일 구독 요청"""
    email: EmailStr


class SubscribeResponse(BaseModel):
    """이메일 구독 응답"""
    status: str
    message: str
    email: str


class UnsubscribeResponse(BaseModel):
    """구독 취소 응답"""
    status: str
    message: str
