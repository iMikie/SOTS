class PasswordResetsController < ApplicationController

  def new
    #default html.erb fall through
    @error = nil
  end

  def create #post receipt of user request to reset password from login -> reset-password
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      @user = User.new
      @user.errors.add(:authorization_error, "That email not found")
      render password_resets_new_path
    end
  end

  def edit
    @user = get_user
    # if valid_user(@user)
    valid_user(@user)
    log_in(@user)
    redirect_to "/users/change_password/#{@user.id}"
  # else
  #   redirect_to root_url
  # end
end

private

def get_user
  @user = User.find_by(email: params[:email])

end

# Confirms a valid user.
def valid_user(user)
  user.authenticated?(:reset, params[:id]) #digest was encoded in hidden field of form
end

# Checks expiration of reset token.
def check_expiration
  if @user.password_reset_expired?
    flash[:danger] = "Password reset has expired."
    redirect_to new_password_reset_url
  end
end

end
