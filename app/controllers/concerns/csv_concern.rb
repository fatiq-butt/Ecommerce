module CsvConcern
  extend ActiveSupport::Concern

  def generate_csv(model, attributes)
    CsvFormat.generate_csv(model.constantize, attributes)
  end
end
