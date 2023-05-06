class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :end_user_id, null: false
      t.string :facility_name, null: false
      t.string :address, null: false
      t.string :detailed_description, null: false

      t.timestamps
    end
  end
end
