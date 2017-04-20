class StaticPagesController < ApplicationController
  before_action :load_categories, only: :index
  def contact
  end

  def help
    NotificationJob.perform_now 1, "abc"
  end

  def index
    @support = Supports::StaticPageSupport.new
  end

  def error
  end
end
