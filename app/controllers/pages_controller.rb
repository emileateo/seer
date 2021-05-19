class PagesController < ApplicationController
  def home
  end

  def preview
    @birth_date = params['date']
    @birth_time = params['time']
  end

  def preferences
    @user = current_user
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
