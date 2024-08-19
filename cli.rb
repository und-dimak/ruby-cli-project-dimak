# frozen_string_literal: true
require 'thor'
require 'exif'

class CLI < Thor
  desc "scan", "Recursively reads all of the images from the supplied directory"
  option :path, type: :string, required: false, desc: "Optional parameter that allows any other directory to be passed in."

  def scan
    File.open("report.csv", "w") do |report|
      Dir.glob("**/*").each do |file|
        next unless File.file?(file)

        data = get_exif(file)
        next unless data

        report.puts(:"File:#{file}")
        report.puts(:"GPS data:#{data[:gps]}")
        report.puts(:"--------------------------")
      end
    end
  end

  private

  def get_exif(file)
    Exif::Data.new(File.open(file))
  rescue Exif::NotReadable
    nil
  end
end

CLI.start(ARGV)