module Snorby
  module Migrations
    class Icmp
      include DataMapper::Resource

      storage_names[:default] = "icmphdr"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :icmp_type, Integer, :lazy => true

      property :icmp_code, Integer, :lazy => true

      property :icmp_csum, Integer, :lazy => true

      property :icmp_id, Integer, :lazy => true

      property :icmp_seq, Integer, :lazy => true

    end
  end
end
