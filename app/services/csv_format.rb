class CsvFormat
  
  private

  def self.to_csv model,*args
    attributes = %w{id title price description status}
    CSV.generate(headers: true) do |csv|
      csv << args
      model.all.each do |model|
        csv << attributes.map{ |attr| model.send(attr) }
      end
    end
  end
  
end
