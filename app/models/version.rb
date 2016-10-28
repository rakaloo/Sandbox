class Version < ApplicationRecord
  belongs_to :article, required: false
  belongs_to :editor, class_name: "User"

  validates :body, length: { minimum: 10 }
  validates :title, length: { minimum: 2 }
end
