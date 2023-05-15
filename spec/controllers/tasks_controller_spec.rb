require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'filters tasks by priority' do
      high_priority_task = FactoryBot.create(:task, priority: 'high', user: user)
      low_priority_task = FactoryBot.create(:task, priority: 'low', user: user)

      get :index, params: { priority: 'high' }

      expect(assigns(:tasks)).to include(high_priority_task)
      expect(assigns(:tasks)).not_to include(low_priority_task)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new task' do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    it 'creates a new task' do
      expect do
        post :create, params: { task: FactoryBot.attributes_for(:task) }
      end.to change(Task, :count).by(1)
    end

    it 'redirects to the tasks index' do
      post :create, params: { task: FactoryBot.attributes_for(:task) }
      expect(response).to redirect_to(tasks_path)
    end
  end

  describe 'GET #edit' do
    let(:task) { FactoryBot.create(:task, user: user) }

    it 'renders the edit template' do
      get :edit, params: { id: task.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns the correct task' do
      get :edit, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'PATCH #update' do
    let(:task) { FactoryBot.create(:task, user: user) }

    it 'updates the task' do
      patch :update, params: { id: task.id, task: { title: 'New Title' } }
      task.reload
      expect(task.title).to eq('New Title')
    end

    it 'redirects to the tasks index' do
      patch :update, params: { id: task.id, task: { title: 'New Title' } }
      expect(response).to redirect_to(tasks_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'soft deletes the task' do
      delete :destroy, params: { id: task.id }
      task.reload

      expect(task.deleted_at).not_to be_nil
    end

    it 'redirects to the tasks index page' do
      delete :destroy, params: { id: task.id }

      expect(response).to redirect_to(tasks_path)
    end
  end

  describe 'GET #logs' do
    it 'renders the logs template' do
      get :logs, params: { id: task.id }

      expect(response).to render_template('tasks/logs')
    end

    it 'assigns the correct task to @task' do
      get :logs, params: { id: task.id }

      expect(assigns(:task)).to eq(task)
    end

    it 'renders without the layout' do
      get :logs, params: { id: task.id }

      expect(response).to render_template(layout: false)
    end
  end
end
