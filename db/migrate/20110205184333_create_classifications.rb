class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table(:classifications) do |t|
      t.string :name
      t.text :description
      t.integer :hotkey
      t.boolean :locked, :default => 0
      t.integer :events_count, :default => 0
      
      t.timestamps
    end
    
    add_index :classifications, :hotkey
    add_index :classifications, :locked
    add_index :classifications, :events_count
    
  end

  def self.down
    drop_table :classifications
  end
end
