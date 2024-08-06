# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def callback
    @message = params[:message] || "Please log in to access this page"
    @token = params[:token]
  end
end
