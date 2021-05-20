class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preview]

  def home
  end

  def preview
    @birth_date = params['date']
    @birth_time = params['time']
  end

  def dashboard
    @preferred_posts = current_user.preferred_posts.sample # [ P1, P2]
    # @todays_post =
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
