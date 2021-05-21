require 'json'
require 'open-uri'
require 'zodiac'
require 'date'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preview]

  def home
  end

  def preview
    @name = params[:name]
    @birth_date = params[:date]
    @year = params[:year].to_i

    visitor_birth_date = Time.new(params[:date])
    visitor_birth_date_reversed = visitor_birth_date.strftime("%d/%m/%Y")

    url = "https://api.vedicastroapi.com/json/prediction/numerology?name=#{params[:name]}&show_same=true&date=#{visitor_birth_date_reversed}&type=TYPE&api_key=9ad6241b-9b66-5990-95b1-63654815da21"
    fortune_serialized = URI.open(url).read
    @fortune = JSON.parse(fortune_serialized)

    if (@year - 2000) % 12 == 0
        @sign = 'Dragon'
    elsif (@year - 2000) % 12 == 1
        @sign = 'Snake'
    elsif (@year - 2000) % 12 == 2
        @sign = 'Horse'
    elsif (@year - 2000) % 12 == 3
        @sign = 'Sheep'
    elsif (@year - 2000) % 12 == 4
        @sign = 'Monkey'
    elsif (@year - 2000) % 12 == 5
        @sign = 'Rooster'
    elsif (@year - 2000) % 12 == 6
        @sign = 'Dog'
    elsif (@year - 2000) % 12 == 7
        @sign = 'Pig'
    elsif (@year - 2000) % 12 == 8
        @sign = 'Rat'
    elsif (@year - 2000) % 12 == 9
        @sign = 'Ox'
    elsif (@year - 2000) % 12 == 10
        @sign = 'Tiger'
    else
        @sign = 'Hare'
    end
  end

  def dashboard
    @user = current_user
    @preferred_posts = current_user.preferred_posts.sample # [P1, P2]
    # @todays_post =

    @appointments = Appointment.all

    @unaccepted_appointments = Appointment.where(status: false)
    @accepted_appointments = Appointment.where(status: true)
    @accepted_appointments.order!(:when)
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
