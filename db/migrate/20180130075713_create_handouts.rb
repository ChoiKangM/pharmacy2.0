class CreateHandouts < ActiveRecord::Migration[5.0]
  def change
    create_table :handouts do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
