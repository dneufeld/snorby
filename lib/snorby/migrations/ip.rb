module Snorby
  module Migrations
    class Ip
      include DataMapper::Resource

      storage_names[:default] = "iphdr"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :ip_src, String, :index => true, :min => 0, :required => true, :default => 0

      property :ip_dst, String, :index => true, :min => 0, :required => true, :default => 0

      property :ip_ver, Integer, :min => 0, :required => true, :default => 0

      property :ip_hlen, Integer, :min => 0, :required => true, :default => 0

      property :ip_tos, Integer, :min => 0, :required => true, :default => 0

      property :ip_len, Integer, :min => 0, :required => true, :default => 0

      property :ip_id, Integer, :min => 0, :required => true, :default => 0

      property :ip_flags, Integer, :min => 0, :required => true, :default => 0

      property :ip_off, Integer, :min => 0, :required => true, :default => 0

      property :ip_ttl, Integer, :min => 0, :required => true, :default => 0

      property :ip_proto, Integer, :min => 0, :required => true, :default => 0

      property :ip_csum, Integer, :min => 0, :required => true, :default => 0

    end
  end
end
