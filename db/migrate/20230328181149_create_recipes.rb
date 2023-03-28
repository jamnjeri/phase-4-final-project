class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :ingredients, null: false
      t.string :img_url, null: false
      t.index ["user_id"], name: "index_recipes_on_user_id"

      t.timestamps
    end
  end
end
