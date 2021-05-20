class AppointmentsController < ApplicationController
  def index
    @appointments = Appointments.all
  end


  def approve
  end

  def consulation
  end
end
