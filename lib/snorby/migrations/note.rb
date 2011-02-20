module Snorby
  module Migrations
    class Note
      include DataMapper::Resource

      storage_names[:default] = "notes"
      
      property :id, Serial, :key => true

      property :sid, Integer, :index => true

      property :cid, Integer, :index => true

      property :user_id, Integer, :index => true

      property :body, Text, :lazy => true

      timestamps :at

    end
  end
end
