class Admin::SuggestsController < ApplicationController
  layout "admin_layout"
  before_action :check_admin

  def index
    @suggests = Suggest.all_suggest.paginate page: params[:page],
      per_page: Settings.maximum_per_page
  end

  def update
    @suggest = Suggest.find_by id: params[:id]
    if @suggest
      @suggest.status = Suggest.statuses[@suggest.status] + 1
      if @suggest.save
        notification = NotificationMessage.new
        notification.user_id = @suggest.user_id
        notification.content = t("noti.suggest", id: @suggest.id, status: @suggest.status)
        notification.url = suggests_path
        if notification.save
          NotificationJob.perform_now notification
        end
        flash[:success] = t "update_status_success"
      else
        flash[:danger] = t "update_status_fail"
      end
    else
      flash[:danger] = t "find_error"
    end
    redirect_to :back
  end
end
