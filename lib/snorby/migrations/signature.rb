module Snorby
  module Migrations
    class Signature
      include DataMapper::Resource

      storage_names[:default] = "signature"

      property :sig_id, Serial, :key => true, :index => true

      property :sig_class_id, Integer, :index => true

      property :sig_name, Text

      property :sig_priority, Integer, :index => true

      property :sig_rev, Integer, :lazy => true

      property :sig_sid, Integer, :lazy => true

      property :sig_gid, Integer, :lazy => true

      property :events_count, Integer, :index => true, :default => 0

    end
  end
end
