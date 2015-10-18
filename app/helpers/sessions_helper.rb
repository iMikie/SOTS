module SessionsHelper


  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:current_user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:current_user_id)
    cookies.delete(:remember_token)
  end

  def log_in(user)
    session[:current_user_id] = user.id
  end

  def log_out
    if logged_in?
      forget(current_user)
      session.delete(:current_user_id)
      @current_user = nil
    end
  end

  def current_user
    if session[:current_user_id]
      @current_user ||= User.find(session[:current_user_id])
    elsif (user_id = cookies.signed[:current_user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end

    end
  end

  #see that user is logged in and if a user_id is passed, make sure it's the id
  # #of the logged_in user}

  def authorize_user(user_id = nil)

    if !logged_in?
      redirect_to root_path
    else
      user = current_user
      if user_id.nil? || user_id == user.id #if no user_id passed, then not checking it
        return user
      else
        user.errors.add(:authorization_error, "Not authorized for that action") unless user.nil?
        redirect_to user_path
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

end