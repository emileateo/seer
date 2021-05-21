require 'json'
require 'open-uri'
require 'zodiac'
require 'date'
require 'nokogiri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preview]

  def home
  end

  def preview
    @name = params[:name]
    @birth_date = params[:date]

    @visitor_birth_date = Date.parse(params[:date])
    @year = @visitor_birth_date.year
    @visitor_birth_date_reversed = @visitor_birth_date.strftime("%d/%m/%Y")

    url = "https://api.vedicastroapi.com/json/prediction/numerology?name=#{params[:name]}&show_same=true&date=#{@visitor_birth_date_reversed}&type=TYPE&api_key=9ad6241b-9b66-5990-95b1-63654815da21"
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

    zodiac_url = "https://chinesenewyear.net/zodiac/#{@sign.downcase}/"
    html_file = URI.open(zodiac_url).read
    html_doc = Nokogiri::HTML(html_file)

    parsed_content = html_doc.search('.article-content.page-section p').first
    @parsed_text = parsed_content.text.strip
  end

  def dashboard
    @user = current_user
    @preferred_posts = current_user.preferred_posts.sample # [P1, P2]
    # @todays_post =

    @appointments = Appointment.all

    @unaccepted_appointments = Appointment.where(status: false)
    @accepted_appointments = Appointment.where(status: true).order!(:when)
  end

  def preferences
    @user = current_user
    @categories = Category.all
  end

  def studiespost
  end

  def careerpost
  end

  def relationshippost
  end

  def healthpost
  end
end
