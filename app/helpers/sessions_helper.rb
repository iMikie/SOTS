module SessionsHelper


  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:current_user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget #nil out remember_digest
    cookies.delete(:current_user_id)
    cookies.delete(:remember_token)
  end

  def log_in(user)
    session[:current_user_id] = user.id
  end

  def log_out
    if logged_in?
      forget current_user
      session.delete(:current_user_id)
      @current_user = nil
    end
  end

  def current_user
    if (user_id = session[:current_user_id])
      @current_user ||= User.find_by(id: user_id) #how do we know @current_user is valid?
    elsif (user_id = cookies.signed[:current_user_id])
      user = User.find_by(id: cookies.signed[:current_user_id])
      if user && user.authenticated?(cookies[:remember_token]) #check encrypted token
        log_in user
        @current_user = user
      end

    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def admin_user?
    user = current_user
    user && user.admin
  end

  #see that user is logged in and if a user_id is passed, make sure it's the id
  # #of the logged_in user}

  def current_user_authorized?(options)

    c_user = current_user
    return false if !c_user
    return true if c_user.admin

    case options[:task]
      when :edit_profile
        id = options[:user_id]
        if id.to_i != c_user.id
          flash[:info] = "Not authorized"
          redirect_to root_url
          return false
        else
          return true
        end
      when :delete_user
        if c_user.admin
          return true
        else
          flash[:info] = "Not authorized for killing people"
          redirect_to root_url
        end
      when :admin_task
        # !admin_user?
        flash[:info] = "That action require admin privileges"
        redirect_to root_url
      when :member_task
        if logged_in?
          return true
        else
          flash[:info] = "Must be logged in"
          redirect_to root_url
        end
    end

    false
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !(current_user.nil?)
  end

end