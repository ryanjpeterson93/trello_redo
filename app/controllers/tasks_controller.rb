class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:show, :destroy, :update, :edit]
  def index
    @tasks = Task.all_tasks(@list.id)
  end

  def show
  end

  def new
    @task = @list.tasks.new
  end

  def create
    Task.create_task(task_params, @list.id)
    # @task = @list.tasks.new(task_params)
    # @task.save
    if 
      redirect_to board_path(@list.board_id)
    else  
      render :new
    end
  end

  def edit
  end

  def update
    Task.update_task(@task.id, customer_params)
    # @task.update(task_params)
    if
      redirect_to list_path(@list)
    else  
      render :edit
    end
  end

  def destroy
    Task.delete_task(@task.id)
    # @task.destroy
    redirect_to list_path(@list)
  end

  private

    def set_list
      @list = List.find(params[:list_id])
      # @list = List.find(params[:list_id])
    end

    def set_task
      @task = Task.single_task(@list.id, params[:id])
    end

    def task_params
      params.require(:task).permit(:priority, :name, :body)
    end
end
