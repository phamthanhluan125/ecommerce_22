class AdminController < ApplicationController
  layout "admin_layout"
  before_action :check_admin

  def check_admin
    if current_user.nil?
      redirect_to root_path
    else
      if !current_user.is_admin?
        redirect_to root_path
      end
    end
  end
end
