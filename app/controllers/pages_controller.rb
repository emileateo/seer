class PagesController < ApplicationController
  def home
  end

  def preview
    @birth_date = params['date']
    @birth_time = params['time']
  end
end
