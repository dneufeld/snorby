module Snorby
  module Migrations
    class Udp
      include DataMapper::Resource

      storage_names[:default] = "udphdr"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :udp_sport, Integer, :index => true

      property :udp_dport, Integer, :index => true

      property :udp_len, Integer

      property :udp_csum, Integer

    end
  end
end
