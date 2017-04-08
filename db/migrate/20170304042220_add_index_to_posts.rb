class AddIndexToPosts < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :name, unique: true
  end
end
