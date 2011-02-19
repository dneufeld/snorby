class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table(:category, :id => false) do |t|
      t.integer :sig_class_id, :primary_key => true
      t.string :sig_class_name
      
      t.timestamps
    end
    
    add_index :category, :sig_class_id
  end

  def self.down
    drop_table :category
  end
end
