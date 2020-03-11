class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
  
    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_url, notice: t('controllers.sessions.successfully_logged_in')
    else
      flash.now.alert = t('controllers.sessions.invalid_email_or_password')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('controllers.sessions.you_are_logged_out')
  end
end
