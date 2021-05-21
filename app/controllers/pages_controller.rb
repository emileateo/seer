class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preview]

  def home
  end

  def preview
    @birth_date = params['date']
    @birth_time = params['time']
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
