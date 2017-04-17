class CategoriesController < ApplicationController
  before_action :load_categories, only: :show

  def show
    @categorie = Categorie.find_by id: params[:id]
    arr = list_cate_parent(@categories, @categorie, [])
    @products = load_all_products arr
  end

  private

  def load_all_products arr
    products = Product.all
    @products = []
    arr.each do |a|
      @products += a.products
    end
    @products
  end

  def list_cate_parent categories, categorie, arr
    list = categories.select {|n| n.parent_id == categorie.id}
    if list.count > 0
      list.each do |l|
       arr = list_cate_parent(categories, l, arr)
      end
    end
    return arr.push categorie
  end
end
