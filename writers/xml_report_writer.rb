require 'builder'

module Writers
  class XmlReportWriter
    def self.write(...) = new.write(...)

    def write(data)
      File.open('report.xml', 'w') do |file|
        xml = Builder::XmlMarkup.new(target: file, indent: 2)
        xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
        xml.files do
          data.each do |file_name, gps|
            xml.file { |b| b.name(file_name); b.data(gps) }
          end
        end
      end
    end
  end
end
