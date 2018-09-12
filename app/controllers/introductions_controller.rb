class IntroductionsController < ApplicationController
  before_action :authenticate_user!, only: [:attendance,:operationCommittee,:secondGrade16,:thirdGrade15,:fourthGrade14,:fifthGrade13]
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
  def secondGrade16
     @secondGrade16 = [ "16 신미경.jpg","16 곽철영.jpg","16 구현진.jpg","16 김가영.jpg","16 김규비.jpg",
                        "16 김예린.jpg","16 김재훈.jpg","16 김태수.jpg","16 노수경.jpg","16 노현석.jpg",
                        "16 류현재.jpg","16 문운정.jpg","16 박승박.jpg","16 박채영.jpg","16 백선화.jpg",
                        "16 백지원.jpg","16 백진향.jpg","16 신희진.jpg","16 여인제.jpg","16 오유림.jpg",
                        "16 윤정혁.jpg","16 이윤지.jpg","16 이해림.jpg","16 임재원.jpg","16 정규원.jpg",
                        "16 정덕주.jpg","16 진기찬.jpg","16 천효빈.jpg","16 최소영.jpg","16 황수현.jpg"]
                        # 5 * 6 = 30
  end
  def thirdGrade15
     @thirdGrade15 =  [ "13 장연준.JPG","15 양현석.jpg","15 강재언.jpg","15 오성현.jpg","15 김경민.JPG",		
                        "15 우지훈.jpg","15 김민정.JPG","15 윤동호.jpg","15 김세송.jpg","15 윤석민.jpg",
                        "15 김수빈.jpg","15 이민주.JPG","15 김승현.jpg","15 이안나.jpg","15 김지원.jpg",		
                        "15 이지우.jpg","15 김혜정.JPG","15 임지헌.jpg","15 남영관.jpg","15 전지혜.JPG",
                        "15 문은기.jpg","15 정명진.jpg","15 박원범.jpg","15 최정인.jpg","15 배한울.jpg",		
                        "15 허종범.JPG","15 서인혁.jpg","15 홍근상.jpg","15 손유정.JPG","15 홍다영.JPG",
                        "15 신민아.jpg"]
                        # 5 * 6 + 1 = 31
  end
  def fourthGrade14
      @fourthGrade14 = ["11 박대희.jpg","14 손재영.jpg","14 곽은영.jpg","14 이가윤.jpg","14 김광진.jpg",
                        "14 이동규.jpg","14 김동환.jpg","14 이동후.jpg","14 김성민.jpg","14 이수경.jpg",
                        "14 김윤재.jpg","14 이수춘.jpg","14 김재학.jpg","14 이재운.jpg","14 김지수.jpg",
                        "14 이준규.jpg","14 김지연.jpg","14 정선영.jpg","14 김지혜.jpg","14 정연웅.jpg",
                        "14 김현아.JPG","14 주민정.JPG","14 류나현.JPG","14 채성배.jpg","14 박혜민.jpg",
                        "14 최기웅.JPG","14 박희정.jpg","14 최준용.jpg","14 서봉수.jpg","14 한준범.jpg"]
                        # 5 * 6 = 30
  end
  def fifthGrade13
      @fifthGrade13 = [ "10 박준형.jpg","13 박나희.jpg","11 박영빈.jpg","13 박희경.jpg","11 최태명.jpg",
                        "13 방진웅.jpg","12 구영모.jpg","13 배진주.jpg","12 서영준.jpg","13 손지영.jpg",
                        "12 심유리.jpg","13 윤원상.jpg","12 윤태균.jpg","13 이우인.jpg","12 이애림.jpg",
                        "13 이정석.jpg","13 강재연.jpg","13 이준성.jpg","13 구인혜.jpg","13 이지훈.jpg",
                        "13 김가현.jpg","13 이진형.jpg","13 김건희.jpg","13 이태원.jpg","13 김규성.jpg",
                        "13 이효정.jpg","13 김보영.jpg","13 장병철.jpg","13 김보철.jpg","13 정호정.jpg",
                        "13 김은선.jpg","13 채수빈.jpg","13 김정우.jpg","13 최다예.jpg","13 김환식.jpg",
                        "13 황연미.jpg","13 박거성.jpg"]
                        # 5 * 7 + 2 = 37
  end
  def operationCommittee
    # B6 - 운영위원
  end
  
  
  
end
