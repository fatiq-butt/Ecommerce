module CategoriesHelper
  def category_drop_down
    Category.all.map{|cat| [cat.name,cat.id]}
  end
end
