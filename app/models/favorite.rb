require 'snorby/model/counter'

class Favorite < ActiveRecord::Base
  
  include Snorby::Model::Counter

  belongs_to :user
  
  belongs_to :event, :foreign_key => [:sid, :cid]

  after_create do
    self.event.up(:users_count) if self.event
    self.user.up(:favorites_count) if self.user
  end
  
  before_destroy do
    self.event.down(:users_count) if self.event
    self.user.down(:favorites_count) if self.user
  end

end
