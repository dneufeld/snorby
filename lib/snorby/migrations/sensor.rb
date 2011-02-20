module Snorby
  module Migrations
    class Sensor
      include DataMapper::Resource

      storage_names[:default] = "sensor"

      property :sid, Serial, :key => true, :index => true

      property :name, String, :default => 'Click To Change Me'

      property :hostname, Text, :index => true

      property :interface, Text

      property :filter, Text

      property :detail, Integer, :index => true

      property :encoding, Integer, :index => true

      property :last_cid, Integer, :index => true

      property :events_count, Integer, :index => true, :default => 0

    end
  end
end
