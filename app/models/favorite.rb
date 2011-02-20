class Favorite < ActiveRecord::Base

  belongs_to :event, :foreign_key => [:sid, :cid]

  belongs_to :user
  
  
  after_create do
    user.increment!(:favorites_count)
    event.increment!(:users_count)
  end
  
  after_destroy do
    user.decrement!(:favorites_count)
    event.decrement!(:users_count)
  end
  
end
