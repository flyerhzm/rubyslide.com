class CreateSlides < ActiveRecord::Migration
  def self.up
    create_table :slides do |t|
      t.string :title
      t.text :description
      t.string :username
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :slides
  end
end
