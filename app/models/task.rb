class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :priority, :project, presence: true
  has_many :comments, dependent: :destroy
end
