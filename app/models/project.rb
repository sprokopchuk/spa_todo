class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :user, :name, presence: true
  default_scope { order("created_at ASC") }
end
