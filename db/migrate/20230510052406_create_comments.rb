class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.references :end_user,foreign_key: true
      t.references :post, foreign_key: true
      t.text :comment,nul: false

      t.timestamps
    end
  end
end
