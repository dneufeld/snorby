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
    class Ip
      include DataMapper::Resource

      storage_names[:default] = "iphdr"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :ip_src, Integer, :index => true, :min => 0, :required => true

      property :ip_dst, Integer, :index => true, :min => 0, :required => true

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
