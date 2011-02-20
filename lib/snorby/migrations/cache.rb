module Snorby
  module Migrations
    class Cache

      include DataMapper::Resource

      storage_names[:default] = "caches"

      property :id, Serial

      property :sid, Integer

      property :cid, Integer

      property :ran_at, DateTime

      property :event_count, Integer, :default => 0

      property :tcp_count, Integer, :default => 0

      property :udp_count, Integer, :default => 0

      property :icmp_count, Integer, :default => 0

      property :severity_metrics, Object

      property :signature_metrics, Object

      property :src_ips, Object

      property :dst_ips, Object

    end
  end
end
