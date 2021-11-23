require 'csv'
class CsvFormat
  
  private

  def self.generate_csv model,attributes
    CSV.generate(headers: true) do |csv|
      csv << attributes
      model.all.each do |model|
        csv << attributes.map{ |attr| model.send(attr) }
      end
    end
  end
  
end
