module Snorby
  module Migrations
    class Favorite
      include DataMapper::Resource

      storage_names[:default] = "favorites"

      property :id, Serial, :index => true

      property :sid, Integer, :index => true

      property :cid, Integer, :index => true

      property :user_id, Integer, :index => true

    end
  end
end
