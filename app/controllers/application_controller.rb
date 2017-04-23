class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_cart
  before_action :load_notification_message
  include SessionsHelper

  before_filter :set_locale

  def default_url_options
    {locale: I18n.locale}
  end

  def function_logged_in_use
    if current_user.nil?
      redirect_to error_path
    end
  end

  def create_cart
    if session[:cart].nil?
      session[:cart] = []
    end
  end

  def check_admin
    if current_user.nil?
      redirect_to root_path
    else
      if !current_user.is_admin?
        redirect_to root_path
      end
    end
  end

  def load_categories
    @categories = Categorie.all
  end

  def load_notification_message
    if loged?
      notification_messages_not_seen = NotificationMessage.notification_of_user_not_seen(current_user.id)
      notification_messages_seen = NotificationMessage.notification_of_user_seen(current_user.id,
        (Settings.maximum_notify_message - notification_messages_not_seen.count))
      @notification_messages = notification_messages_not_seen+ notification_messages_seen
      @count_notification_not_send = NotificationMessage.all_notification_not_seen(current_user.id).count
    end
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
