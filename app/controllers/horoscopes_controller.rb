require 'open-uri'
require 'nokogiri'

class HoroscopesController < ApplicationController
  def show
    horoscope_page = URI::open('https://astrologyk.com/horoscope/chinese/daily').read
    doc = Nokogiri::HTML(horoscope_page)
    text = doc.search('p')[1].text
    # when I get the request
    # go to nokogiri
    # go to the website that has the forecast
    # parse the html that I want
    # return it as Json to the chrome extension
    respond_to do |format|
      format.json { render json: { horoscope: text }}
    end
  end
end
