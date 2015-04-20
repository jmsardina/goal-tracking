class Activity < ActiveRecord::Base
  attr_accessor :number_occurences
	belongs_to :goal
	# has_many :comments, as: :commentable, dependent: :destroy
	delegate :user, to: :goal
  validates :description, presence: true
  validates :frequency, :period, presence: true

  before_save :default_values
  def default_values
    self.remaining_for_period ||= self.frequency
  end

  def complete?
    self.status == true
  end

  def incomplete?
    status == false
  end

  def activity_timeline
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

  def periods_in_timeline #returns the number of periods within the activity timeline
  	if days_in_period
      activity_timeline / days_in_period
    end
  end

  def number_occurences #returns the total number of times an activity will occur
  	if periods_in_timeline
      self.frequency * periods_in_timeline
    end
  end

  def cycle_start_date #returns the first date of the cycle
    (self.upcoming_due_dates.first - 1.send(self.period))
  end

  def valid_period_dates #returns a range (period start date..period end date)
    self.cycle_start_date..self.upcoming_due_dates.first
  end

  def needs_counter_reset? #returns true if activity has not been completed this cycle.
    self.updated_at < cycle_start_date
  end

  def restart_activity_counter #reset remaining_for_period to frequency at start of new period
    if self.needs_counter_reset?
      self.remaining_for_period = self.frequency
      self.save
    end
  end

  def upcoming_due_dates #returns an array of the periodic activity due dates
    start_date = self.created_at.to_date
    upcoming = []

    while start_date < self.goal.due_date
      if (start_date + 1.send(self.period)) <= self.goal.due_date
        new_due_date = start_date + 1.send(self.period)
        upcoming << new_due_date
        start_date = new_due_date
      else
        upcoming << self.goal.due_date unless upcoming.include?(self.goal.due_date)
        start_date = self.goal.due_date
      end
    end
    upcoming.delete(upcoming[0]) if Time.now.to_date >= upcoming[0]
    upcoming
  end


  def add_point_and_decrement_occurences
    @user = self.user
    if self.complete?
      unless self.remaining_for_period == 0
        self.decrement!(:occurences)
        self.increment!(:activity_points)
        self.decrement!(:remaining_for_period)
        self.goal.increment!(:goal_points)
        @user.increment!(:points)
      end
      self.status = false
      self.save
    end
  end

end
