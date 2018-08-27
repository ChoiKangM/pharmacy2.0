class CreateAlumnusfees < ActiveRecord::Migration[5.0]
  def change
    create_table :alumnusfees do |t|
      t.string :title
      t.text :content
      t.string :accounts
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
