class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :attachment_url, :attachment_filename, :task_id


  def attachment_url
    object.attachment.url unless object.attachment.file.nil?
  end

  def attachment_filename
    object.attachment.file.filename unless object.attachment.file.nil?
  end
end

