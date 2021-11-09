class CsvFormat
  
  private

  def self.to_csv model,*args
    attributes = args
    CSV.generate(headers: true) do |csv|
      csv << args
      model.all.each do |model|
        csv << attributes.map{ |attr| model.send(attr) }
      end
    end
  end
  
end
