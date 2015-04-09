class Goal < ActiveRecord::Base

	has_many :activities, dependent: :destroy
	has_many :goal_tags
	has_many :tags, through: :goal_tags
	has_many :comments, as: :commentable, dependent: :destroy
	belongs_to :user

  def days_left
    (self.due_date - Time.now.to_date).to_i
  end

  def past_due?
  	Time.now.to_date > self.due_date
  end


end
