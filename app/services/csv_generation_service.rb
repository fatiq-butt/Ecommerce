require 'csv'

class CsvGenerationService
  def initialize(model)
    @model = model.constantize
    @attributes = @model.attributes
  end

  def call
    CSV.generate(headers: true) do |csv|
      csv << @attributes
      @model.all.each do |model|
        csv << @attributes.map{ |attr| model.send(attr) }
      end
    end
  end
end
