class SessionController < ApplicationController

  def create
    user = User.find_by(username:
    user_params[:username])

    if user && user.authenticate(user_params[:password])

      # check back to see if token = SecureRandom.urlsafe_base64 is needed

      session[:current_user_id] = user.id
      flash[:message] = "thanks, logged in"
      redirect_to application_mapp_path
    else
      flash[:message] = "username / password combo error"
      redirect_to root_path
    end

  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end

  def current_tripper
    # amiloggedin = !!session[:current_user_id]
    # render json: current_user
  end


  private

  def user_params
    # do we need other ones here if we just use the two below to log in???
    return params.require(:user).permit(:username, :password, :user_marker)
  end

end
