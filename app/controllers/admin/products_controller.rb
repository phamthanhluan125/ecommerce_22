class Admin::ProductsController < AdminController
  layout "admin_layout"
  before_action :check_admin
  before_action :load_product, only: [:destroy, :update]

  def new
    @list = tree_categorie Categorie.all, 0, [], ""
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "created_product"
      redirect_to new_admin_product_path
    else
      @list = tree_categorie Categorie.all, 0, [], ""
      render :new
    end
  end

  def destroy
    if @product.order_details.size > 0
      flash[:danger] = t("delete_product_error",
        number: @product.order_details.size)
    else
      if @product.destroy
        flash[:success] = t "delete_product_success"
      else
        flash[:danger] = t "delete_product_fail"
      end
    end
    redirect_to admin_products_path
  end

  def index
    @list = tree_categorie Categorie.all, 0, [], ""
    @products = Product.paginate page: params[:page],
      per_page: Settings.maximum_per_page
  end

  def update
    product = Product.find_by id: params[:id]
    @product = product_params
    if product.status != "selling" && @product["status"] == "selling"
      if product.update_attributes product_params
        @user_regiter_email = product.notification_emails.count_email_regiter
        @user_regiter_email.transaction do
          @user_regiter_email.each do |u|
            @user = u.user
            if @user
              ProductMaillerMailer.regiter_product(@user, product).deliver
              @noti = NotificationEmail.find_by id: u.id
              @noti.is_sended = true
              @noti.save
            end
          end
        end
        flash[:success] = t "update_product_success"
      else
        flash[:danger] = t "update_product_fail"
      end
    else
      if product.update_attributes product_params
        flash[:success] = t "update_product_success"
      else
        flash[:danger] = t "update_product_fail"
      end
    end
    redirect_to :back
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "find_error"
    redirect_to admin_product_path
  end

  def product_params
    params.require(:product).permit :name, :info, :price, :status, :image, :categorie_id
  end

  def tree_categorie categories, parent, list, title
    categories.each do |cate|
      if cate.parent_id == parent
        list.push([title + "" + cate.name, cate.id])
        list = tree_categorie categories, cate.id, list, title + "--"
      end
    end
    return list
  end
end
