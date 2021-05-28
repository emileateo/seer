require 'json'
require 'open-uri'
require 'zodiac'
require 'date'

class LovesController < ApplicationController
  def index
  end

  def show
    @lover_name = params[:name]
    @lover_birth_date = params[:date]
    @lover_birth_date_parsed = Date.parse(@lover_birth_date)
    @lover_zodiac = lover_zodiac(@lover_birth_date_parsed)

    url = "https://api.vedicastroapi.com/json/matching/western?boy_sign=#{@user_zodiac}&girl_sign=#{@lover_zodiac}&api_key=#{ENV["ASTRO_API_KEY"]}"

    love_compatibility = JSON.parse(URI.open(url).read)

    @love_result = love_compatibility["response"]["score"]

    @your_year = current_user.birthdate.year
    @lover_year = @lover_birth_date_parsed.year

    @your_chinese_zodiac = chinese_zodiac(@your_year)
    @lover_chinese_zodiac = chinese_zodiac(@lover_year)
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

  def chinese_zodiac(year)
    case (year - 2000) % 12
    when 0 then @sign = 'Dragon'
    when 1 then @sign = 'Snake'
    when 2 then @sign = 'Horse'
    when 3 then @sign = 'Sheep'
    when 4 then @sign = 'Monkey'
    when 5 then @sign = 'Rooster'
    when 6 then @sign = 'Dog'
    when 7 then @sign = 'Pig'
    when 8 then @sign = 'Rat'
    when 9 then @sign = 'Ox'
    when 10 then @sign = 'Tiger'
    when 11 then @sign = 'Hare'
    end
  end
end
