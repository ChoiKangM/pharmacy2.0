class CreateNreplies < ActiveRecord::Migration[5.0]
  def change
    create_table :nreplies do |t|
      t.text :content
      t.belongs_to :user, foreign_key: true
      t.belongs_to :notice, foreign_key: true

      t.timestamps
    end
  end
end
