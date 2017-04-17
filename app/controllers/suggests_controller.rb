class SuggestsController < ApplicationController
  before_action :function_logged_in_use, only:[:index, :create, :show]
  before_action :load_categories, only:[:index, :new]
  def index
    @suggests = Suggest.paginate page: params[:page],
<<<<<<< HEAD
      per_page: Settings.maximum_per_page
=======
        per_page: Settings.maximum_per_page
>>>>>>> multi
  end

  def create
    @suggest = Suggest.new suggest_params
    if @suggest.save
      flash[:success] = "send_suggest_success";
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

  def suggest_params
    params.require(:suggest).permit(:info).merge user_id: current_user.id
  end
end
