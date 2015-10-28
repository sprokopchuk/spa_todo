class CommentsController < ApplicationController

  load_and_authorize_resource :task
  load_and_authorize_resource :through => :task

  def index
    render json: @comments
  end

  def create
    if @comment.save
      render template: :show, json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render template: :show, json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  def attach_file
    if @comment.update(attachment: params[:comment][:attachment])
      render json: @comment, status: :ok
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:id, :body, :attachment, :task_id)
    end
end
