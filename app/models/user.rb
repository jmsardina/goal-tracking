class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :feeds
  has_many :goals
  has_many :comments

  has_many :groups, foreign_key: :creator_id

  #as member
  has_many :user_groups, foreign_key: :member_id
  has_many :groups, through: :user_groups

  #as invitation sender:
  has_many :requests_sent, class_name: "Invitation", foreign_key: :sender_id
  #as invitation recipient
  has_many :requests_received, class_name: "Invitation", foreign_key: :recipient_id

  has_many :goals
  has_many :activities, through: :goals
  has_many :comments
  has_many :cheers
  # has_many :groups, through: :user_groups

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true

  def self.search(query)
    where("email like ?", "%#{query}%")
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.avatar_file_name = "Profile Picture"
      user.image_url = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_facebook_oauth(oauth_hash, current_user)
    if User.find_by(provider: oauth_hash["provider"], uid: oauth_hash["uid"])
      @user = User.find_by(provider: oauth_hash["provider"], uid: oauth_hash["uid"])
    else
      @user = self.from_omniauth(oauth_hash)
    end
    @user
  end

  def user_board_count
    self.groups.map {|group| group.boards.count}.inject(:+)
  end

  # for a user get me all the goals self.goals
  # count the activities for each goal

  def activity_count_array
    user_goals = self.goals
    user_goals.map {|goal| goal.activities.count}
  end

  def total_remaining_occurences # total remaining occurences for a user
    if self.activities.any?
      self.activities.pluck(:occurences).inject(:+)
    else
      0
    end
  end

  def total_occurences # total occurences for a user
    if self.activities.any?
      self.activities.map {|activity| activity.number_occurences}.inject(:+)
    else
      0
    end
  end

  def completed_activity_occurences
    ( total_occurences - total_remaining_occurences)
    # binding.pry
  end

  def overall_percentage_complete
    ((completed_activity_occurences / total_occurences.to_f) * 100).round(1)
  end




end
