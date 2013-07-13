class ChangeToText < ActiveRecord::Migration
  def up
    change_column :episodes, :description, :text
  end

  def down
    change_column :episodes, :description, :string
  end
end
