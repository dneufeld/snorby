class Tcp < ActiveRecord::Base

  set_table_name "tcphdr"
  
  set_primary_keys :sid, :cid
  
  belongs_to :sensor, :foreign_key => [:sid]
  belongs_to :event, :foreign_key => [:sid, :cid]

end
