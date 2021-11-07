module AdminHelper

  def sorting_method(column)
    if(params[:sort] == column && params[:order] == "ASC")
      "DESC"
    else
      "ASC"
    end
  end
  
end
