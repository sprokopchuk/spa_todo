require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) {FactoryGirl.build_stubbed :user}
  let(:project) {FactoryGirl.build_stubbed :project, user: user}
  let(:task) {FactoryGirl.build_stubbed :task, project: project}
  let(:comment) {FactoryGirl.build_stubbed :comment, task: task}
  before do
    setup user
    @ability.can :manage, :all
    allow(Project).to receive(:find).and_return project
    allow(Task).to receive(:find).and_return task
  end

  describe "POST #create" do

    let(:comment_params) {FactoryGirl.attributes_for :comment}

    before do
      allow(Comment).to receive(:new).and_return comment
    end
    context "with valid params" do

      before do
        allow(comment).to receive(:save).and_return true
      end
      it "assigns a newly created comment as @comment" do
        post :create, project_id: project.id, task_id: task.id, :comment => comment_params, format: :json
        expect(assigns(:comment)).not_to be_nil
      end

      it "return status :created in json format" do
        post :create, project_id: project.id, task_id: task.id, :comment => comment_params, format: :json
        expect(response).to be_created
      end
    end

    context "with invalid params" do

      before do
        allow(comment).to receive(:save).and_return false
      end
      it "return status :unprocessable_entity in json format" do
        post :create, project_id: project.id, task_id: task.id, :comment => comment_params, format: :json
        expect(response).to be_unprocessable
      end
    end


    context "cancan doesn't allow :create" do
      before do
        @ability.cannot :create, comment
        post :create, project_id: project.id, task_id: task.id, format: :json, comment: comment_params
      end
      it {expect(response).to be_forbidden}
    end


  end

  describe "PUT #update" do
    let(:comment_params) {FactoryGirl.attributes_for :comment}

    before do
      allow(task).to receive_message_chain(:comments, :find).and_return comment
      allow(comment).to receive(:update).and_return true
    end

    context "with valid params" do

      it "receive update for comment" do
        expect(comment).to receive(:update).with(comment_params)
        put :update, project_id: project.id, task_id: task.id, id: comment.id, :comment => comment_params, format: :json
      end

      it "assigns the requested comment as @comment" do
        put :update, project_id: project.id, task_id: task.id, id: comment.id, :comment => comment_params, format: :json
        expect(assigns(:comment)).not_to be_nil
      end

      it "return status :ok" do
        put :update, project_id: project.id, task_id: task.id, id: comment.id, :comment => comment_params, format: :json
        expect(response).to be_ok
      end
    end

    context "with invalid params" do
      before do
        allow(comment).to receive(:update).and_return false
      end
      it "return status :unprocessable_entity" do
        post :update, project_id: project.id, task_id: task.id, id: comment.id, :comment => comment_params, format: :json
        expect(response).to be_unprocessable
      end
    end

    context "cancan doesn't allow :update" do
      before do
        @ability.cannot :update, comment
        post :update, project_id: project.id, task_id: task.id, id: comment.id, comment: comment_params, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

  describe "DELETE #destroy" do

    before do
      allow(task).to receive_message_chain(:comments, :find).and_return comment
    end

    it "return status :no_content" do
      allow(comment).to receive(:destroy).and_return true
      delete :destroy, project_id: project.id, task_id: task.id, :id => comment.id, format: :json
      expect(response.status).to eq(204)
    end

    context "cancan doesn't allow :destroy" do
      before do
        @ability.cannot :destroy, comment
        delete :destroy, project_id: project.id, task_id: task.id, id: comment.id, format: :json
      end
      it {expect(response).to be_forbidden}
    end

  end

end
