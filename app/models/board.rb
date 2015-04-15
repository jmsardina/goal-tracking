class Board < ActiveRecord::Base
  belongs_to :group
  has_many :comments, as: :commentable
end
