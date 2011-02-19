# Define the snort schema version
SnortSchema.create(:vseq => 107, :ctime => Time.now, :version => "Snorby #{Snorby::VERSION}") if SnortSchema.first.blank?

# Default user setup
User.create(:name => 'Administrator', :email => 'snorby@snorby.org', :password => 'snorby', :password_confirmation => 'snorby', :admin => true) if User.all.blank?

# Snorby General Settings
if Setting.all.blank?
  Setting.create(:company => 'Snorby.org',
  :email => 'snorby@snorby.org',
  :signature_lookup => 'http://rootedyour.com/snortsid?sid=$$gid$$:$$sid$$',
  :daily => true,
  :weekly => true,
  :monthly => true,
  :lookups => true,
  :notes => true,
  :packet_capture_url => nil,
  :packet_capture => nil,
  :packet_capture_type => :openfpc,
  :packet_capture_auto_auth => false,
  :packet_capture_user => nil,
  :packet_capture_password => nil,
  )
end

# Load Default Classifications

default_classifications = [
  ['Unauthorized Root Access', 1],
  ['Unauthorized User Access', 2],
  ['Attempted Unauthorized Access', 3],
  ['Denial of Service Attack', 4],
  ['Policy Violation', 5],
  ['Reconnaissance', 6],
  ['Virus Infection', 7],
  ['False Positive', 8]
]

default_classifications.each do |name, hotkey|
  
  Classification.find_or_create_by_name({
    :name => name,
    :description => name,
    :hotkey => hotkey,
    :locked => true
  })
  
end

# Load Default Severities
if Severity.all.blank?
  Severity.create(:id => 1, :sig_id => 1, :name => 'High Severity', :text_color => "#ffffff", :bg_color => "#ff0000")
  Severity.create(:id => 2, :sig_id => 2, :name => 'Medium Severity', :text_color => "#ffffff", :bg_color => "#fab908")
  Severity.create(:id => 3, :sig_id => 3, :name => 'Low Severity', :text_color => "#ffffff", :bg_color => "#3a781a")
end
