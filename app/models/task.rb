class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, :priority, :project, presence: true
  has_many :comments, dependent: :destroy
  default_scope { order("created_at ASC") }
end
