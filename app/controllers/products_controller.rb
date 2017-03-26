class ProductsController < ApplicationController
  layout "admin_layout"

  def new
    @categories = Categorie.all
    @product = Product.new
  end

  def create
    @categories = Categorie.all
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "created_product"
      redirect_to test_path
    else
     render :new
    end
  end

  def index
    @categ = Categorie.all
    cate_def = Categorie.new
    cate_def.id = 0
    cate_def.name = "all_categorie"
    @all_product = Product.all
  end

  def testx

  end

  private

  def product_params
    params.require(:product).permit :name, :info, :price, :image, :categorie_id
  end
end
