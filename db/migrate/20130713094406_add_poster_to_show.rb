class AddPosterToShow < ActiveRecord::Migration
  def change
    add_column :shows, :poster, :text

  end
end
