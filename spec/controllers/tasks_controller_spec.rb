require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  let(:user) {FactoryGirl.build_stubbed :user}
  let(:project) {FactoryGirl.build_stubbed :project, user: user}
  let(:task) {FactoryGirl.build_stubbed :task, project: project}
  before do
    setup user
    @ability.can :manage, :all
    allow(Project).to receive(:find).and_return project
  end

  describe "GET #index" do

    before do
      allow(Task).to receive(:accessible_by).and_return [task]
    end

    it "assigns all tasks as @tasks" do
      get :index, project_id: project.id, format: :json
      expect(assigns(:tasks)).to eq([task])
    end

    it "render @tasks in json format" do
      get :index, project_id: project.id, format: :json
      expect(response.body).to eq([task].to_json)
    end

    context "cancan doesn't allow :index" do
      before do
        @ability.cannot :read, project
        get :index, project_id: project.id, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

  describe "POST #create" do

    let(:task_params) {FactoryGirl.attributes_for :task}

    before do
      allow(Task).to receive(:new).and_return task
    end
    context "with valid params" do

      before do
        allow(task).to receive(:save).and_return true
      end
      it "assigns a newly created task as @task" do
        post :create, project_id: project.id, :task => task_params, format: :json
        expect(assigns(:task)).not_to be_nil
      end

      it "return status :created in json format" do
        post :create, project_id: project.id, :task => task_params, format: :json
        expect(response).to be_created
      end
    end

    context "with invalid params" do

      before do
        allow(task).to receive(:save).and_return false
      end
      it "return status :unprocessable_entity in json format" do
        post :create, project_id: project.id, :task => task_params, format: :json
        expect(response).to be_unprocessable
      end
    end


    context "cancan doesn't allow :create" do
      before do
        @ability.cannot :create, task
        post :create, project_id: project.id, format: :json, task: task_params
      end
      it {expect(response).to be_forbidden}
    end


  end

  describe "PUT #update" do
    let(:task_params) {FactoryGirl.attributes_for :task}

    before do
      allow(project).to receive_message_chain(:tasks, :find).and_return task
      allow(task).to receive(:update).and_return true
    end

    context "with valid params" do

      it "receive update for task" do
        expect(task).to receive(:update).with(task_params)
        put :update, project_id: project.id, id: task.id, :task => task_params, format: :json
      end

      it "assigns the requested task as @task" do
        put :update, project_id: project.id, id: task.id, :task => task_params, format: :json
        expect(assigns(:task)).not_to be_nil
      end

      it "return status :ok" do
        put :update, project_id: project.id, id: task.id, :task => task_params, format: :json
        expect(response).to be_ok
      end
    end

    context "with invalid params" do
      before do
        allow(task).to receive(:update).and_return false
      end
      it "return status :unprocessable_entity" do
        post :update, project_id: project.id, id: task.id, :task => task_params, format: :json
        expect(response).to be_unprocessable
      end
    end

    context "cancan doesn't allow :update" do
      before do
        @ability.cannot :update, task
        post :update, project_id: project.id, id: task.id, task: task_params, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

  describe "DELETE #destroy" do

    before do
      allow(project).to receive_message_chain(:tasks, :find).and_return task
    end

    it "return status :no_content" do
      allow(task).to receive(:destroy).and_return true
      delete :destroy, project_id: project.id, :id => task.id, format: :json
      expect(response.status).to eq(204)
    end

    context "cancan doesn't allow :destroy" do
      before do
        @ability.cannot :destroy, task
        delete :destroy, project_id: project.id, id: task.id, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

end
