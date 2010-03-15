require 'lib/migrate'

class AddMapBugTables < ActiveRecord::Migration
  def self.up

	create_enumeration :map_bug_status_enum, ["open", "closed","hidden"]

    create_table :map_bugs do |t|
      t.column :id, :bigint, :null => false 
      t.integer :latitude, :null => false 
      t.integer :longitude, :null => false 
      t.column :tile, :bigint, :null => false
      t.datetime :last_changed, :null => false
      t.datetime :date_created, :null => false 
      t.string :nearby_place 
      t.string :text
	  t.column :status, :map_bug_status_enum, :null => false
	  
    end

    add_index :map_bugs, [:tile,:status], :name => "map_bugs_tile_idx"
	add_index :map_bugs, [:last_changed], :name => "map_bugs_changed_idx"
	add_index :map_bugs, [:date_created], :name => "map_bugs_created_idx"
  end

  def self.down
    remove_index :map_bugs, :name => "map_bugs_tile_idx"
	remove_index :map_bugs, :name => "map_bugs_changed_idx"
	remove_index :map_bugs, :name => "map_bugs_created_idx"
    drop_table :map_bugs
	drop_enumeration :map_bug_status_enum
  end
end