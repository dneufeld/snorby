class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table(:event, :id => false, :primary_key => :cid) do |t|
      t.column :sid, :primary_key, :null => false
      t.integer :cid, :null => false
      
      t.integer :sig_id
      t.integer :classification_id, :null => true
      
      t.integer :users_count, :default => 0
      t.integer :notes_count, :default => 0
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :event, :sid
    add_index :event, :cid
    add_index :event, :sig_id
    add_index :event, :classification_id
    add_index :event, :user_id
    
  end

  def self.down
    drop_table :event
  end
end