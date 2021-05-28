require 'json'
require 'open-uri'
require 'zodiac'
require 'date'
require 'nokogiri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preview]

  def home
    redirect_to dashboard_path if user_signed_in?
  end

  def preview
    api_key = '74740b9d-27b4-5322-b45c-b37be2586038'
    @name = params[:name]
    @birth_date = params[:date]

    @visitor_birth_date = Date.parse(params[:date])
    @year = @visitor_birth_date.year
    @visitor_birth_date_reversed = @visitor_birth_date.strftime("%d/%m/%Y")

    url = "https://api.vedicastroapi.com/json/prediction/numerology?name=#{params[:name]}&show_same=true&date=#{@visitor_birth_date_reversed}&type=TYPE&api_key=#{api_key}"
    fortune_serialized = URI.open(url).read
    @fortune = JSON.parse(fortune_serialized)

    case (@year - 2000) % 12
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

    # zodiac_url = "https://chinesenewyear.net/zodiac/#{@sign.downcase}/"
    # html_file = URI.open(zodiac_url).read
    # html_doc = Nokogiri::HTML(html_file)

    # parsed_content = html_doc.search('.article-content.page-section p').first
    # @parsed_text = parsed_content.text.strip

    todays_reading = "https://api.vedicastroapi.com/json/prediction/dailysun?zodiac=#{(@year - 2000) % 12 + 1}&show_same=true&date=#{Time.now.strftime("%d/%m/%Y")}&type=TYPE&api_key=#{api_key}&split=true"

    todays_fortune = JSON.parse(URI.open(todays_reading).read)

    post_category = Category.all.sample

    @post = Post.create!(
      title: post_category.name,
      description: todays_fortune["response"]["bot_response"][post_category.name.downcase]["split_response"],
      category: post_category
    )
  end

  def dashboard
    api_key = '74740b9d-27b4-5322-b45c-b37be2586038'
    @user = current_user
    @user.master = false unless @user.master
    @user_zodiac = user_zodiac(@user)
    # raise

    url = "https://api.vedicastroapi.com/json/prediction/dailysun?zodiac=#{@user_zodiac}&show_same=true&date=#{Time.now.strftime("%d/%m/%Y")}&type=TYPE&api_key=#{api_key}&split=true"

    # prediction is for the day itself
    fortune = JSON.parse(URI.open(url).read)

    @user.lucky_number = fortune["response"]["lucky_number"][0]
    @user.lucky_color = fortune["response"]["lucky_color"]
    @user.save
    @preferred_posts = current_user.preferred_posts.sample # [P1, P2]
    # @todays_post =

    @appointments = Appointment.all

    @unaccepted_appointments = Appointment.where(status: false)
    @accepted_appointments = Appointment.where(status: true).order!(:when)

    if @user.master
      @unaccepted_appointments = Appointment.where(status: false, master: @user).order(when: :asc)
      @accepted_appointments = Appointment.where(status: true, master: @user, payment_status: 'pending').order(when: :asc)
      @confirmed_appointments = Appointment.where(payment_status: 'paid', master: @user).order(when: :asc)
    end

  end

  def preferences
    @user = current_user
    @categories = Category.all
  end

  private

  def user_zodiac(user)
    case user.birthdate.zodiac_sign
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

  # def studiespost
  # end

  # def careerpost
  # end

  # def relationshippost
  # end

  # def healthpost
  # end
end
