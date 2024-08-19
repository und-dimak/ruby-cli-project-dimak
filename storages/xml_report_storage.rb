require 'builder'

class XmlReportStorage
  def save(data)
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

  def self.save(data)
    XmlReportStorage.new.save(data)
  end

end
