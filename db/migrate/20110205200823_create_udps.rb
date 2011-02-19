class CreateUdps < ActiveRecord::Migration
  def self.up  
    create_table(:udphdr) do |t|
      t.integer :sid
      t.integer :cid
      t.integer :udp_sport
      t.integer :udp_dsport
      t.integer :udp_len
      t.integer :udp_csum
    end
    
    add_index :udphdr, :sid
    add_index :udphdr, :cid
    
  end

  def self.down
    drop_table :udphdr
  end
end
