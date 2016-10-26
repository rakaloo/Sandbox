class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.string :title
      t.string :body
      t.belongs_to :article, foreign_key: true
      t.belongs_to :editor, class_name: "User", foreign_key: true

      t.timestamps
    end
  end
end
