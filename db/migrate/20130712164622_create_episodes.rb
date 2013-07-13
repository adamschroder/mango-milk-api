class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :description
      t.string :air_date
      t.integer :season
      t.integer :number
      t.integer :show_id

      t.timestamps
    end
  end
end
