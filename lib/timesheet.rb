require 'extensions/date'
require 'google_drive'

class Timesheet
  DEFAULT_PATH = 'timesheet'

  def initialize(h={:configfile => "#{ENV['HOME']}/.timesheet.yml"})
    @config = YAML.load File.read h[:configfile] # TODO: not from file
  end

  def connect
    @google_drive = GoogleDrive.login(@config[:username], @config[:password])
  end

  def method_missing(id, *args, &blk)
    @google_drive.send id, *args, &blk
  end
end
