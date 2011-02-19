class CreateIps < ActiveRecord::Migration
  def self.up  
    create_table(:iphdr) do |t|
      t.integer :sid
      t.integer :cid
      t.integer :ip_src, :default => 0
      t.integer :ip_dst, :default => 0
      t.integer :ip_ver, :default => 0
      t.integer :ip_hlen, :default => 0
      t.integer :ip_tos, :default => 0
      t.integer :ip_len, :default => 0
      t.integer :ip_id, :default => 0
      t.integer :ip_flags, :default => 0
      t.integer :ip_off, :default => 0
      t.integer :ip_ttl, :default => 0
      t.integer :ip_proto, :default => 0
      t.integer :ip_csum, :default => 0
    end
    
    add_index :iphdr, :sid
    add_index :iphdr, :cid  
    add_index :iphdr, :ip_src
    add_index :iphdr, :ip_dst   
    
  end

  def self.down
    drop_table :iphdr
  end
end
