class Activity < ActiveRecord::Base
  attr_accessor :number_occurences
	belongs_to :goal
	# has_many :comments, as: :commentable, dependent: :destroy
	delegate :user, to: :goal

  def complete?
    self.status == true
  end

  def incomplete?
    status == false
  end

  def activity_range
  	(self.goal.due_date - self.created_at.to_date).to_i
  end

  def days_in_period
  	case self.period
  	when "day"
  		time = 1
  	when "week"
  		time = 7
  	when "month"
  		time = 30
  	when "year"
  		time = 365
  	end
  	time
  end

  def periods_in_range
  	activity_range / days_in_period
  end

  def number_occurences
  	self.frequency * periods_in_range
  end

  def upcoming_due_dates
    start_date = self.created_at.to_date
    upcoming = []
    while start_date < self.goal.due_date
      if (self.goal.due_date - start_date).to_i >= self.days_in_period
       new_due_date = start_date + 1.send(self.period)
        upcoming << new_due_date
        start_date = new_due_date
      else
        upcoming.delete(upcoming[0]) if Time.now.to_date > upcoming[0]
        upcoming
      end
    end
    upcoming.delete(upcoming[0]) if Time.now.to_date > upcoming[0]
    upcoming
  end

  # def past_due_date?
  #   Time.now.to_date > upcoming_due_dates.first
  # end

  def add_point_and_decrement_occurences
    @user = self.user
    if self.complete?
      unless self.remaining_for_period == 0
        self.decrement!(:occurences)
        self.increment!(:activity_points)
        self.decrement!(:remaining_for_period)
        @user.increment!(:points)
      end
      self.status = false
      self.save
    else

    end
  end
end
