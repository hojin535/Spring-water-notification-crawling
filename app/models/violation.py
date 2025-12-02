"""
먹는물영업자 위반현황 데이터 모델
"""
from typing import Optional
from pydantic import BaseModel, Field


class ViolationListItem(BaseModel):
    """메인 페이지 목록 항목 모델"""
    순번: str = Field(..., description="순번")
    품목: str = Field(..., description="품목")
    업체명: str = Field(..., description="업체명")
    제품명: str = Field(..., description="제품명")
    처분명: str = Field(..., description="처분명")
    처분일자: str = Field(..., description="처분일자")
    공표마감일자: str = Field(..., description="공표마감일자")
    상세URL: Optional[str] = Field(None, description="상세 페이지 URL")


class ViolationDetail(BaseModel):
    """상세 페이지 데이터 모델"""
    품목: str = Field(..., description="품목")
    업체명: str = Field(..., description="업체명")
    업체소재지: str = Field(default="", description="업체소재지")
    제품명: str = Field(default="", description="제품명")
    업종명: str = Field(default="", description="업종명")
    공표마감일자: str = Field(..., description="공표마감일자")
    처분명: str = Field(..., description="처분명")
    처분기간: str = Field(..., description="처분기간")
    위반내용: str = Field(default="", description="위반내용")
    처분일자: str = Field(..., description="처분일자")
