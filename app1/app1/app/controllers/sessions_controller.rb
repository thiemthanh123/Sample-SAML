# app/controllers/sessions_controller.rb ở App 1
class SessionsController < ApplicationController
  before_action :check_login, except: [:destroy]

  def new
    @redirect_url = params[:redirect_url] || "http://localhost:3001"
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user[:email] == "thiem"
      token = generate_token(@user)
      User.update(cookie: token)
      session[:user_id] = token
      redirect_to "#{params[:redirect_url]}?token=#{token}&message=#{@user[:email]}" if (!params.nil? && !params[:redirect_url].nil? && params[:redirect_url].include?('3001'))
      render :success if (params.nil? || params[:redirect_url].nil? || params[:redirect_url].include?('3000'))
    else
      redirect_to "#{params[:redirect_url]}?message=Please log in to access this page"
    end
  end


  def check_login
    if session[:user_id]
      @user = User.find_by(cookie: session[:user_id])
      redirect_to "#{params[:redirect_url]}?token=#{session[:user_id]}&message=#{@user[:email]}" if (!params.nil? && !params[:redirect_url].nil? && params[:redirect_url].include?('3001'))
      render :success  if (params.nil? || params[:redirect_url].nil? || params[:redirect_url].include?('3000'))
    end
  end

  def destroy
    session[:user_id] = nil
    User.update_all(cookie: nil)

    render :new
  end

  private

  def generate_token(user)
    # Implement token generation logic
    SecureRandom.hex(10)
  end
end
