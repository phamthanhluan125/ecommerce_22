class SuggestsController < ApplicationController
  before_action :function_logged_in_use, only:[:index, :create, :show]
  before_action :load_categories, only:[:index, :new]
  def index
    @suggests = Suggest.suggests_of_user(current_user.id).paginate page: params[:page],
      per_page: Settings.maximum_per_page
  end

  def create
    @suggest = Suggest.new suggest_params
    if @suggest.save
      flash[:success] = "send_suggest_success";
      send_notification @suggest
      SuggestMailer.resuggest_user(current_user, @suggest.id).deliver
    else
      flash[:danger] = "send_suggest_fail";
    end
    redirect_to suggests_path
  end

  def new
    @suggest = Suggest.new
  end

  private

  def send_notification suggest
    admins = User.all_admin
    admins.each do |a|
      notification = NotificationMessage.new
      notification.content = t "noti.new.suggest"
      notification.url = admin_suggests_path
      notification.user_id = a.id
      if notification.save
        NotificationJob.perform_now notification
      end
    end
    notification = NotificationMessage.new
    notification.content = t("noti.suggest", id: suggest.id, status: suggest.status)
    notification.url = suggests_path
    notification.user_id = current_user.id
    if notification.save
      NotificationJob.perform_now notification
    end
  end

  def suggest_params
    params.require(:suggest).permit(:info).merge user_id: current_user.id
  end
end
