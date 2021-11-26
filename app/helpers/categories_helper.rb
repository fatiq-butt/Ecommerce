module CategoriesHelper
  def category_options
    Category.all.map { |cat| [cat.name, cat.id] }
  end
end
