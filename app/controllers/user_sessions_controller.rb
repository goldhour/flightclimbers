class UserSessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password], params[:remember])
        format.html { redirect_back_or_to( current_user, :notice => 'Login successfull.') }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
      end
    end
  end

  def destroy
    logout
    redirect_to(:users, :notice => 'Logged out!')
  end
end
