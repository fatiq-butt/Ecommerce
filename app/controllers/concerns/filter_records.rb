module FilterRecords
  extend ActiveSupport::Concern

  def sort_page_filter(model)
    @records = model.all
    @records = @records.global_search(params[:search]) if params[:search].present?
    @records = @records.order(params[:sort] => params[:order]) if params[:order].present?
    @pagy, @records = pagy(@records, items: 5)
  end
end
