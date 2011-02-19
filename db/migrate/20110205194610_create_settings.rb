class CreateSettings < ActiveRecord::Migration
  def self.up  
    create_table(:settings) do |t|
      t.string :company
      t.string :email
      t.string :signature_lookup
      
      t.boolean :daily
      t.boolean :weekly
      t.boolean :monthly
      t.boolean :lookups
      t.boolean :notes
      t.boolean :packet_capture
      
      t.string :packet_capture_url
      t.string :packet_capture_type
      t.boolean :packet_capture_auto_auth
      
      t.string :packet_capture_user
      t.string :packet_capture_password
      
    end
    
  end

  def self.down
    drop_table :settings
  end
end
