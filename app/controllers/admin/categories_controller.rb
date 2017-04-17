class Admin::CategoriesController < AdminController
  layout "admin_layout"
  before_action :check_admin
  before_action :load_categorie, only: [:destroy, :update]

  def new
    @list = tree_categorie Categorie.all, 0, [], ""
    @list.unshift([t("chooseparent"),0])
    @categorie = Categorie.new
    @categories = Categorie.paginate page: params[:page],
      per_page: Settings.maximum_per_page
  end

  def create
    @categorie = Categorie.new categorie_params
    if @categorie.save
      flash[:success] = t "created_categorie"
      redirect_to new_admin_category_path
    else
      @list = tree_categorie Categorie.all, 0, [], ""
      render :new
    end
  end

  def destroy
    if @categorie.products.size > 0
      flash[:danger] = t("delete_categorie_error",
        number: @categorie.products.size)
    else
      if @categorie.destroy
        flash[:success] = t "delete_categorie_success"
      else
        flash[:danger] = t "delete_categorie_fail"
      end
    end
    redirect_to new_admin_category_path
  end

  def update
    @categorie = Categorie.find_by id: params[:id]
    if @categorie
      if check_parent Categorie.all, @categorie, params[:categorie][:parent_id]
        if @categorie.update_attributes categorie_params
          flash[:success] = t "update_categorie_success"
        else
          flash[:danger] = t "update_categorie_fail"
        end
      else
        flash[:danger] = t "chooseparent_error"
      end
    else
      flash[:danger] = t "find_error"
    end
    redirect_to new_admin_category_path
  end

  private

  def load_categorie
    @categorie = Categorie.find_by id: params[:id]
    return if @categorie
    flash[:danger] = t "find_error"
    redirect_to new_admin_category_path
  end

  def categorie_params
    params.require(:categorie).permit :name, :image, :parent_id
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

  def check_parent categories, categorie, parent_new
    if categorie.id == parent_new.to_i
      false
    else
      arr = list_cate_parent categories, categorie, []
      if arr.count > 0
        if arr.detect {|n| n.id == parent_new.to_i}
          false
        else
          true
        end
      else
        true
      end
    end
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
