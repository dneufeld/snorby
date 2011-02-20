module Snorby
  module Migrations
    class Payload
      include DataMapper::Resource

      storage_names[:default] = "data"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :data_payload, Text

    end
  end
end
