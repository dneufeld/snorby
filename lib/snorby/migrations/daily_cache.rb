module Snorby
  module Migrations

    class DailyCache

      include DataMapper::Resource

      storage_names[:default] = "daily_caches"

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

      property :src_ips, Text

      property :dst_ips, Text

      # Define created_at and updated_at timestamps
      timestamps :at

    end
  end
end
