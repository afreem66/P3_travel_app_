class UsersController < ApplicationController

  # create method for user

  def create
    @user = User.new(user_params)

    if @user.save
      # flash[:message] = "registered, please log in"
      session[:current_user_id] = @user.id
      flash[:message] = "thanks, registered and logged in"
      redirect_to application_mapp_path
    else
      flash[:message] = @user.errors.full_messages.to_sentence
      redirect_to root_path
    end

  end

  def edit
    # --- below is untested code
    @user = User.find(params[:id])
    # --- end
  end

  def update
    # --- below is untested code
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:message] = "User '#{@user.username}' Updated!"
    redirect_to root_path
    # --- end
  end

  def destroy
    # --- below is untested code
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
    # --- end
  end

  # private methods
  private

  def user_params
    return params.require(:user).permit(:email, :password, :username, :full_name, :user_marker)
  end
end
