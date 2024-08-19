class CsvReportStorage
  def save(data)
    CSV.open("report.csv", "w") do |csv|
      csv << ["file name", "GPS data"] # headers

      data.each do |file_name, gps|
        csv << [file_name, gps]
      end
    end
  end

  def self.save(data)
    CsvReportStorage.new.save(data)
  end
end
