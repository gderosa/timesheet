GOOGLE_DRIVE_FORK = File.join File.dirname(__FILE__), '../google-drive-ruby'
GOOGLE_DRIVE_FORK_LIB = File.join GOOGLE_DRIVE_FORK, 'lib'
$LOAD_PATH.unshift GOOGLE_DRIVE_FORK_LIB if Dir.exists? GOOGLE_DRIVE_FORK_LIB

require 'extensions/date'
require 'google_drive'

class Timesheet
  DEFAULT_PATH = ['subdir', 'a', 'sheet']

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

