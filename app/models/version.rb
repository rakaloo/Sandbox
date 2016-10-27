class Version < ApplicationRecord
  belongs_to :article, required: false
  belongs_to :editor, class_name: "User"
end
