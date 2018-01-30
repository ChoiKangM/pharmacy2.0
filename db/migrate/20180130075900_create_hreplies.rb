class CreateHreplies < ActiveRecord::Migration[5.0]
  def change
    create_table :hreplies do |t|
      t.text :content
      t.belongs_to :user, foreign_key: true
      t.belongs_to :handout, foreign_key: true

      t.timestamps
    end
  end
end
