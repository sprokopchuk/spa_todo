class TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :through => :project

  def index
    render json: @tasks
  end

  def create
    if @task.save
      render template: :show, json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render template: :show, json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @task.destroy
    head :no_content
  end

  private

    def task_params
      params.require(:task).permit(:name, :priority, :done, :deadline)
    end
end
