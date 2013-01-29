class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :send_form_authenticity_token

  private
  def send_form_authenticity_token
    response.headers['X-Authenticity-Token'] = form_authenticity_token
  end
end
