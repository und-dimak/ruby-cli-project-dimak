require 'csv'

module Writers
  class CsvReportWriter
    def self.write(...) = new.write(...)

    def write(data)
      CSV.open("report.csv", "w") do |csv|
        csv << ["file name", "GPS data"] # headers

        data.each do |file_name, gps|
          csv << [file_name, gps]
        end
      end
    end
  end

end
