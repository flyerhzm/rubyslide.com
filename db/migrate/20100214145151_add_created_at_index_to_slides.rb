class AddCreatedAtIndexToSlides < ActiveRecord::Migration
  def self.up
    add_index :slides, :created_at
  end

  def self.down
  end
end
