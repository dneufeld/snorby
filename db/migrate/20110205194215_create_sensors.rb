class CreateSensors < ActiveRecord::Migration
  def self.up  
    create_table(:sensor, :id => false) do |t|
      t.column :sid, :primary_key, :null => false
      
      t.string :name
      
      t.text :hostname
      t.string :interface
      t.string :filter
      
      t.integer :detail
      t.integer :encoding
      t.integer :last_cid
      t.integer :events_count, :default => 0
      
    end
    
    add_index :sensor, :sid
    add_index :sensor, :last_cid
    add_index :sensor, :events_count
    
  end

  def self.down
    drop_table :sensor
  end
end
