class Note < ActiveRecord::Base

  belongs_to :user
  
  set_primary_keys :sid, :cid
  
  belongs_to :sensor, :foreign_key => [:sid]
  
  belongs_to :event, :foreign_key => [:sid, :cid]

  validates_presence_of :sensor
  validates_presence_of :event
  
  validates_presence_of :body

  after_create do
    event = self.event
    user = self.user
    event.update(:notes_count => event.notes_count + 1)
    user.update(:notes_count => user.notes_count + 1)
  end
  
  before_destroy do
    event = self.event
    user = self.user
    event.update(:notes_count => event.notes_count - 1) if event
    user.update(:notes_count => user.notes_count - 1) if user
  end

  def html_id
    "note_#{id}"
  end

end
