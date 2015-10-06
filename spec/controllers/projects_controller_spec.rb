require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:user) {FactoryGirl.build_stubbed :user}
  let(:project) {FactoryGirl.build_stubbed :project, user: user}

  before do
    setup user
    @ability.can :manage, Project
  end
  describe "GET #index" do

    before do
      allow(Project).to receive(:accessible_by).and_return [project]
    end

    it "assigns all projects as @projects" do
      get :index, format: :json
      expect(assigns(:projects)).to eq([project])
    end

    it "render @projects in json format" do
      get :index, format: :json
      expect(response.body).to eq([project].to_json)
    end

    context "cancan doesn't allow :index" do
      before do
        @ability.cannot :read, Project
        get :index, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

  describe "POST #create" do

    let(:project_params) {FactoryGirl.attributes_for :project}

    before do
      allow(controller).to receive(:current_user).and_return user
      allow(Project).to receive(:new).and_return project
    end
    context "with valid params" do

      before do
        allow(project).to receive(:save).and_return true
      end
      it "assigns a newly created project as @project" do
        post :create, :project => project_params, format: :json
        expect(assigns(:project)).not_to be_nil
      end

      it "return status :created in json format" do
        post :create, :project => project_params, format: :json
        expect(response).to be_created
      end
    end

    context "with invalid params" do

      before do
        allow(project).to receive(:save).and_return false
      end
      it "return status :unprocessable_entity in json format" do
        post :create, :project => project_params, format: :json
        expect(response).to be_unprocessable
      end
    end


    context "cancan doesn't allow :create" do
      before do
        @ability.cannot :create, Project
        post :create, format: :json, project: project_params
      end
      it {expect(response).to be_forbidden}
    end


  end

  describe "PUT #update" do
    let(:project_params) {FactoryGirl.attributes_for :project}

    before do
      allow(Project).to receive(:find).and_return project
      allow(project).to receive(:update).and_return true
    end

    context "with valid params" do

      it "receive update for project" do
        expect(project).to receive(:update).with(project_params)
        put :update, id: project.id, :project => project_params, format: :json
      end

      it "assigns the requested project as @project" do
        put :update, id: project.id, :project => project_params, format: :json
        expect(assigns(:project)).not_to be_nil
      end

      it "return status :ok" do
        put :update, id: project.id, :project => project_params, format: :json
        expect(response).to be_ok
      end
    end

    context "with invalid params" do
      before do
        allow(project).to receive(:update).and_return false
      end
      it "return status :unprocessable_entity" do
        post :update, id: project.id, :project => project_params, format: :json
        expect(response).to be_unprocessable
      end
    end

    context "cancan doesn't allow :update" do
      before do
        @ability.cannot :update, Project
        post :update, id: project.id, project: project_params, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

  describe "DELETE #destroy" do

    before do
      allow(Project).to receive(:find).and_return project
    end

    it "return status :no_content" do
      allow(project).to receive(:destroy).and_return true
      delete :destroy, :id => project.id, format: :json
      expect(response.status).to eq(204)
    end

    context "cancan doesn't allow :destroy" do
      before do
        @ability.cannot :destroy, Project
        delete :destroy, id: project.id, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

end
