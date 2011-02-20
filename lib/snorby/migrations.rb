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

require 'dm-core'
require 'dm-timestamps'
require "active_record"

require 'snorby/migrations/cache'
require 'snorby/migrations/category'
require 'snorby/migrations/daily_cache'
require 'snorby/migrations/detail'
require 'snorby/migrations/encoding_type'
require 'snorby/migrations/event'
require 'snorby/migrations/favorite'
require 'snorby/migrations/icmp'
require 'snorby/migrations/ip'
require 'snorby/migrations/note'
require 'snorby/migrations/opt'
require 'snorby/migrations/payload'
require 'snorby/migrations/reference'
require 'snorby/migrations/reference_system'
require 'snorby/migrations/sensor'
require 'snorby/migrations/sig_reference'
require 'snorby/migrations/signature'
require 'snorby/migrations/snort_schema'
require 'snorby/migrations/tcp'
require 'snorby/migrations/udp'

module Snorby
  module Migrations
    
    def self.load
      DataMapper::Logger.new(STDOUT, :debug)
      config = "#{Rails.root.to_s}/config/database.yml"

      if File.exists?(config)
        database = YAML.load_file("#{Rails.root.to_s}/config/database.yml").symbolize_keys.clone
        if database.has_key?(:snorby)
          database = database[:snorby]
          database["adapter"] = database["adapter"] == "mysql2" ? "mysql" : database["adapter"]
          DataMapper.setup(:default, database)
          DataMapper.auto_upgrade!
        end
      else
        raise('Error - Unable to locate database.yml')
      end
    end

  end
end
