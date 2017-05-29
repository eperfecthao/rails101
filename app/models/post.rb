class Post < ApplicationRecord
  validates_presence_of :content

  belongs_to :group
  belongs_to :user

  scope :recent, -> { order("created_at DESC")}
end
