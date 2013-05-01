GOOGLE_DRIVE_FORK = File.join File.dirname(__FILE__), '../google-drive-ruby'
GOOGLE_DRIVE_FORK_LIB = File.join GOOGLE_DRIVE_FORK, 'lib'
$LOAD_PATH.unshift GOOGLE_DRIVE_FORK_LIB if Dir.exists? GOOGLE_DRIVE_FORK_LIB

require 'extensions/date'
require 'google_drive'

class Timesheet
  DEFAULT_CONFIG = {
    :remote_path => 'timesheet/timesheet'
  }

  def initialize(h={:configfile => "#{ENV['HOME']}/.timesheet.yml"})
    @config = DEFAULT_CONFIG.merge(YAML.load(File.read h[:configfile])) 
  end

  def connect
    @google_drive = GoogleDrive.login(@config[:username], @config[:password])
  end

  def worksheets
    spreadsheet.worksheets
  end

  def spreadsheet
    return file if 
        file = @google_drive.file_by_title(@config[:remote_path].split('/'))
    STDERR.puts "Spreadsheet #{@config[:remote_path]} must exist (already) in your Google Drive. Create a blank one and it would be just fine."
    exit 1
  end

  #def method_missing(id, *args, &blk)
  #  @google_drive.send id, *args, &blk
  #end
end

