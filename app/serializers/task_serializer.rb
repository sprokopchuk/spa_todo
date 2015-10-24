class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :priority, :deadline, :project_id

  has_many :comments
end
