class AddEmbedToSlides < ActiveRecord::Migration
  def self.up
    add_column :slides, :embed, :string
  end

  def self.down
    remove_column :slides, :embed
  end
end
