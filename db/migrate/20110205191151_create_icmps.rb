class CreateIcmps < ActiveRecord::Migration
  def self.up  
    create_table(:icmphdr) do |t|
      t.integer :sid
      t.integer :cid
      t.integer :icmp_type
      t.integer :icmp_code
      t.integer :icmp_csum
      t.integer :icmp_id
      t.integer :icmp_seq
    end
    
    add_index :icmphdr, :sid
    add_index :icmphdr, :cid    
    
  end

  def self.down
    drop_table :icmphdr
  end
end
