class Version < ApplicationRecord
  belongs_to :article
  belongs_to :editor
end
