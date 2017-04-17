class HomeController < ApplicationController
  def intro
    require 'open-uri'
    require 'json'
    
    lotto_info = JSON.parse(open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read)
    
    # Lotto 정보
    drwNoDate = lotto_info['drwNoDate']
    drwNo = lotto_info['drwNo']
    
    # 이미지
    img_main = "main.png"
    
    # 비둘기
    @img_main = img_main
    @drwNoDate = drwNoDate
    @drwNo = drwNo
  end
  
  def index
    require 'open-uri'
    require 'json'
    
    lotto_info = JSON.parse(open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read)
    
    # Lotto 정보
    drwNoDate = lotto_info['drwNoDate']
    drwNo = lotto_info['drwNo']
    
    # 이미지
    circle1 = "circle1.png"
    circle2 = "circle2.png"
    
    # drw_numbers
    drw_numbers = []
    
    lotto_info.each do |k,v|
      if(k.include? ('drwtNo'))
        drw_numbers << v
      end
    end
    
    drw_numbers.sort!
    
    bonus_number = lotto_info['bnusNo']
    
    btn_sel = params[:btn]
    
    # my_numbers
    if(btn_sel == 'btn_input')
      num1 = params[:num1].to_i
      num2 = params[:num2].to_i
      num3 = params[:num3].to_i
      num4 = params[:num4].to_i
      num5 = params[:num5].to_i
      num6 = params[:num6].to_i
    
      my_numbers = [num1,num2,num3,num4,num5,num6]
      my_numbers.sort!
    else
      my_numbers = (1..45).to_a.sample(6).sort
    end
    
    # 이번주 로또번호와 랜덤 추첨번호에서 겹치는 번호
    match_numbers = drw_numbers.find_all {
      |i| my_numbers.include? i
    }
    
    match_cnt = match_numbers.length
    
    # 등수 구하기
    result = ""
    
    if(match_cnt == 6)
        result = "1등"
    elsif ((match_cnt == 5) && my_numbers.include?(bonus_number))
        result = "2등"
    elsif (match_cnt == 5)
        result = "3등"
    elsif (match_cnt == 4)
        result = "4등"
    elsif (match_cnt == 3)
        result = "5등"
    else
        result = "꽝"
    end
    
    # 비둘기
    @drwNoDate = drwNoDate
    @drwNo = drwNo
    @drw_numbers = drw_numbers
    @bonus_number = bonus_number
    @my_numbers = my_numbers
    @match_numbers = match_numbers
    @match_cnt = match_cnt
    @result = result
    @circle1 = circle1
    @circle2 = circle2
    
  end
end
