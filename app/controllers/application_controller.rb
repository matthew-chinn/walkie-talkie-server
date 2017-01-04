class ApplicationController < ActionController::Base
    before_action :add_header
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def add_header
      response.headers["Access-Control-Allow-Origin"] = "*"
  end

end
