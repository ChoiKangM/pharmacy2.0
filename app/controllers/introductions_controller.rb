class IntroductionsController < ApplicationController
  before_action :authenticate_user!, only: [:attendance,:operationCommittee]
  def userInformation
  end
  
  def main
    # A - 메인 페이지
    # ok
  end
  def mainEvent
    # A1 - Event
    # ok
  end
  def privacyInformation
    # A3 - 개인정보
    # 어디꺼??
  end
  def agreeOfUtil
    # A4 - 이용 약관
    # 어디꺼??
  end
  
  def introduction
    # B - 소개
  end
  def alumni
    # B1 - 동창회
    # main이랑 겹친다
  end
  def studentActivity
    # B2 = 학생활동 or 학생생활
  end
  def village
    # B3 -  빌리지
  end
  def club
    # B4 - 동아리
  end
  def attendance
    # B5 - 회원소개
  end
  def operationCommittee
    # B6 - 운영위원
  end
  
  
  
end
