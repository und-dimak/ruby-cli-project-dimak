# frozen_string_literal: true
require 'thor'
require 'exif'
require_relative 'writers/csv_report_writer'
require_relative 'writers/xml_report_writer.rb'
require_relative 'exif_scanner.rb'

class CLI < Thor
  desc "scan", "Recursively reads all of the images from the supplied directory"
  option :path, type: :string, required: false, desc: "Optional parameter that allows any other directory to be passed in."
  option :format, required: false, default: :csv, desc: "Optional parameter that allows setting specific file formats, either CSV or XML. The default is CSV."

  def scan
    report = ExifScanner::gps(options[:path])

    case options[:format].to_sym
    when :xml
      XmlReportWriter::write(report)
    else
      CsvReportWriter::write(report)
    end
  end

end

CLI.start(ARGV)
