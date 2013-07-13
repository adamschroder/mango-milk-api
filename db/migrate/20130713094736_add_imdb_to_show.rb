class AddImdbToShow < ActiveRecord::Migration
  def change
    add_column :shows, :imdb_id, :text

  end
end
