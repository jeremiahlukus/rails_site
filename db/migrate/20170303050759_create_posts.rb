class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :author
      t.string :title
      t.string :thumbnail_url
      t.string :tags
      t.boolean :published
      t.text :content
      t.datetime :date
    end
  end
end
