class AppointmentsController < ApplicationController
  def index
    @appointments = Appointments.all
  end

  def consulation
  end
end
