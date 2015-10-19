class ProjectsController < ApplicationController

  load_and_authorize_resource

  def index
    render json: @projects
  end

  def create
    @project.user_id = current_user.id
    if @project.save
      render template: :show, json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render template: :show, json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end
end
