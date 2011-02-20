# Snorby - All About Simplicity.
#
# Copyright (c) 2010 Dustin Willis Webber (dustin.webber at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

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
