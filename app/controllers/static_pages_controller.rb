class StaticPagesController < ApplicationController
  before_action :load_categories, only: :index
  def contact
  end

  def help
  end

  def index
    @support = Supports::StaticPageSupport.new
  end

  def error
  end
end
