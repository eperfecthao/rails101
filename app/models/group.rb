class Group < ApplicationRecord
  validates_presence_of :title

  belongs_to :user
  has_many :posts
end
