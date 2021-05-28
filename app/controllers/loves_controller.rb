require 'json'
require 'open-uri'
require 'zodiac'
require 'date'

class LovesController < ApplicationController
 def index
 end




  def show
    @lover_birth_date = params[:date]
    @lover_birth_date_parsed = Date.parse(@lover_birth_date)
    @lover_zodiac = lover_zodiac(@lover_birth_date_parsed)

    url = "https://api.vedicastroapi.com/json/matching/western?boy_sign=#{@user_zodiac}&girl_sign=#{@lover_zodiac}&api_key=9fc5dbe0-8f57-5dc1-8290-ec4ebb99abe5"

    love_compatibility = JSON.parse(URI.open(url).read)

    @love_result = love_compatibility["response"]["bot_response"]

  end

  private

  def lover_zodiac(lover)
    case lover.zodiac_sign
    when "Aries" then @user_zodiac = "1"
    when "Taurus" then @user_zodiac = "2"
    when "Gemini" then @user_zodiac = "3"
    when "Cancer" then @user_zodiac = "4"
    when "Leo" then @user_zodiac = "5"
    when "Virgo" then @user_zodiac = "6"
    when "Libra" then @user_zodiac = "7"
    when "Scorpio" then @user_zodiac = "8"
    when "Sagittarius" then @user_zodiac = "9"
    when "Capricorn" then @user_zodiac = "10"
    when "Aquarius" then @user_zodiac = "11"
    when "Pisces" then @user_zodiac = "12"
    end
  end
end
