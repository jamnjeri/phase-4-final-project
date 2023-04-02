class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :ingredients
      t.string :image_url
      t.integer :user_id, null: false
      
      t.timestamps
      t.index ["user_id"], name: "index_recipes_on_user_id"
    end
  end
end
