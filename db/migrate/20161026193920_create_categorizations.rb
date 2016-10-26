class CreateCategorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :categorizations do |t|
      t.belongs_to :article, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
