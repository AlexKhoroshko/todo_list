class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[edit update destroy logs]

  def index
    @tasks = current_user.tasks.by_priority(params[:priority])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render :form_update, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :form_update, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def logs
    render 'tasks/logs', layout: false
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
