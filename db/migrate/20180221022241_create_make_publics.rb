class CreateMakePublics < ActiveRecord::Migration[5.0]
  def change
    create_table :make_publics do |t|
      t.string :title
      t.text :content
      t.string :information
      t.belongs_to :user, foreign_key: true
      t.string :kind

      t.timestamps
    end
  end
end
