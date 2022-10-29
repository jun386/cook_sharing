class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :user_id
      t.string :image
      t.text :method
      t.integer :genre_id
      t.string :tags

      t.timestamps
    end
  end
end
