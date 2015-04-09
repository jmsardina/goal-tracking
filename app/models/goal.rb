class Goal < ActiveRecord::Base

	has_many :activities, dependent: :destroy
	has_many :goal_tags
	has_many :tags, through: :goal_tags
	has_many :comments, as: :commentable, dependent: :destroy
	belongs_to :user



end
