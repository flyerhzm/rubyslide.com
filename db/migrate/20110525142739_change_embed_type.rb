class ChangeEmbedType < ActiveRecord::Migration
  def self.up
    change_column :slides, :embed, :text
  end

  def self.down
    change_column :slides, :embed, :string
  end
end
