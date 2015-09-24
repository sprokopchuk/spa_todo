class Comment < ActiveRecord::Base
  belongs_to :task
  mount_uploader :attachment, AttachemntUploader
  validates :body, :task, presence: true
end
