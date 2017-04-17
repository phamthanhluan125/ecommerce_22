module ApplicationHelper
  def full_title page_title
    base_title = t "litle_websile"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def count_product_of_cart
    session[:cart].size
  end

  def load_multi_menu categories, categorie_id, html
    categories.each do |cate|
      if cate.parent_id == categorie_id
        if categories.detect {|n| n.parent_id == cate.id}
          html += '<li class="dropdown-submenu">' + link_to(cate.name, category_path(cate.id)) + '<ul class="catalog_item dropdown-menu">'
          html = load_multi_menu categories, cate.id, html
          html += '</ul></li>'
        else
          html += '<li>' + link_to(cate.name, category_path(cate.id)) + '</li>'
        end
      end
    end
    return html
  end

  def check_status_product product
    case
    when product.selling?
      t "product.status.sell"
    when product.soldout?
      t "product.status.sold"
    when product.prepare?
      t "product.status.prepare"
    else
      t "product.status.stop"
    end
  end
end
