module ExifScanner
  def self.gps(path = nil)
    report = {}
    Dir.glob("#{path || "."}/**/*").each do |file|
      next unless File.file?(file)

      data = get_exif(file)
      report[file] = data[:gps] if data
    end
    report
  end

  private

  def self.get_exif(file)
    Exif::Data.new(File.open(file))
  rescue Exif::NotReadable
    nil
  end
end
