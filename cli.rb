# frozen_string_literal: true
require 'thor'
require 'exif'
require 'csv'
require_relative 'storages/csv_report_storage'
require_relative 'storages/xml_report_storage'

class CLI < Thor
  desc "scan", "Recursively reads all of the images from the supplied directory"
  option :path, type: :string, required: false, desc: "Optional parameter that allows any other directory to be passed in."

  def scan
    report = scan_exif(options[:path])
    CsvReportStorage::save(report)
  end

  private

  def scan_exif(path = nil)
    report = {}
    Dir.glob("**/*").each do |file|
      next unless File.file?(file)

      data = get_exif(file)
      report[file] = data[:gps] if data
    end
    report
  end

  def get_exif(file)
    Exif::Data.new(File.open(file))
  rescue Exif::NotReadable
    nil
  end
end

CLI.start(ARGV)
