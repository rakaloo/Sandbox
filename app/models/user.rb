class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :email, { presence: true, uniqueness: true }

  has_many :versions, foreign_key: :editor_id
  has_many :articles, through: :versions
  has_many :categories, through: :articles

end
