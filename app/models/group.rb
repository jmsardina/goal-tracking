class Group < ActiveRecord::Base

  belongs_to :creator, class_name: "User"
  has_many :user_groups
  has_many :members, through: :user_groups

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :tags, as: :taggable
  accepts_nested_attributes_for :tags
  has_many :boards
  has_many :comments, through: :boards
  has_many :comments, as: :commentable
  has_many :invitations, as: :invitable

  validates :name, :creator_id, presence: true
  # validates :name, length: {maximum: 14}
  # validates :description, length: {maximum: 140}
end
