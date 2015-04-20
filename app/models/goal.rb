class Goal < ActiveRecord::Base

	has_many :activities, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  validates :name, :description, presence: true
  validates :due_date, presence: true

  has_many :tags, as: :taggable
  accepts_nested_attributes_for :tags

  def complete?
    self.status == true
  end

  def incomplete?
    self.status == false
  end

  def days_left
    (self.due_date - Time.now.to_date).to_i
  end

  # get the activity occurences related to that goal
  # get the activity remaining occurences for that goal

  def sum_activity_occurences
    if self.activities.any?
      array = []
      self.activities.map do |activity|
        array << activity.number_occurences
      end
      array.inject(:+)
      # binding.presencery
    else
        0
    end
  end

  def sum_remaining_activity_occurences
    if self.activities.any?
      array =[]
      self.activities.each do |activity|
        array << activity.occurences
      end
      array.inject(:+)
    else
      0
    end
  end

  def percentage_activity_complete
    completed = ( sum_activity_occurences - sum_remaining_activity_occurences)
    # binding.pry
    (sum_activity_occurences > 0) ? ((completed / sum_activity_occurences)*100).round(0) : 0
    # binding.pry
  end
end
