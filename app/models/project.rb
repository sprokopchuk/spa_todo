class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :user, :name, presence: true
end
