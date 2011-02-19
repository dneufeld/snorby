class CreateTcps < ActiveRecord::Migration
  def self.up  
    create_table(:tcphdr) do |t|
      t.integer :sid
      t.integer :cid
      t.integer :tcp_sport
      t.integer :tcp_dsport
      t.integer :tcp_seq
      t.integer :tcp_ack
      t.integer :tcp_off
      t.integer :tcp_res
      t.integer :tcp_flags
      t.integer :tcp_win
      t.integer :tcp_csum
      t.integer :tcp_urp
    end
    
    add_index :tcphdr, :sid
    add_index :tcphdr, :cid
    add_index :tcphdr, :tcp_sport
    add_index :tcphdr, :tcp_dsport
    
  end

  def self.down
    drop_table :tcphdr
  end
end
