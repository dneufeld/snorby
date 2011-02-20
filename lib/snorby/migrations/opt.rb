module Snorby
  module Migrations
    class Opt
      include DataMapper::Resource

      storage_names[:default] = "opt"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :optid, Integer, :key => true, :index => true

      property :opt_proto, Integer, :lazy => true

      property :opt_code, Integer, :lazy => true

      property :opt_len, Integer, :lazy => true

      property :opt_data, Text


    end
  end
end
