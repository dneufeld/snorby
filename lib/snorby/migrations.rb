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
          DataMapper.finalize.auto_migrate!
        end
      else
        raise('Error - Unable to locate database.yml')
      end
    end

  end
end
