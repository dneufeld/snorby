class CreateNotes < ActiveRecord::Migration
  def self.up  
    create_table(:notes) do |t|
      t.integer :sid
      t.integer :cid
      t.integer :user_id
      t.text :body
    end
    
    add_index :notes, :sid
    add_index :notes, :cid  
    add_index :notes, :user_id
    
  end

  def self.down
    drop_table :notes
  end
end
