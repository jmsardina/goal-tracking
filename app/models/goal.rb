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

end
