module Snorby
  module Migrations
    class Event
      include DataMapper::Resource

      storage_names[:default] = "event"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :sig_id, Integer, :index => true

      property :classification_id, Integer, :index => true, :required => false

      property :users_count, Integer, :index => true, :default => 0

      property :user_id, Integer, :index => true, :required => false

      property :notes_count, Integer, :index => true, :default => 0

      property :timestamp, DateTime

    end
  end
end
