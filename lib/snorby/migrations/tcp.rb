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
    class Tcp
      include DataMapper::Resource

      storage_names[:default] = "tcphdr"

      property :sid, Integer, :key => true, :index => true

      property :cid, Integer, :key => true, :index => true

      property :tcp_sport, Integer, :index => true

      property :tcp_dport, Integer, :index => true

      property :tcp_seq, Integer

      property :tcp_ack, Integer

      property :tcp_off, Integer

      property :tcp_res, Integer

      property :tcp_flags, Integer

      property :tcp_win, Integer

      property :tcp_csum, Integer

      property :tcp_urp, Integer

    end
  end
end
