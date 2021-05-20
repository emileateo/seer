class ApplicationController < ActionController::Base
redirect-after-signup
before_action :authenticate_user!
end
