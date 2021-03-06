module SessionsHelper
  def loged_admin?
    session[:admin_id].present?
  end

  def login_admin admin
    session[:admin_id] = admin.id
  end

  def logout_admin
    session.delete(:admin_id)
  end

  def log_in user
   session[:user_id] = user.id
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def loged?
    current_user.present?
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
