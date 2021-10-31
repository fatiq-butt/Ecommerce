module UsersHelper

  def sorting_method
    if(params[:order].present? && params[:order] == "DESC") || params[:order].blank?    
      return {order: "ASC"}
    else
      return {order: "DESC"}
    end
  end

end
