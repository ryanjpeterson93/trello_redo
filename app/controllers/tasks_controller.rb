class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:show, :destroy, :update, :edit]
  def index
    @tasks = @list.tasks.all
  end

  def show

  end

  def new
    @task = Task.new
  end

  def create
    @task = @list.tasks.new(task_params)
    if @task.save
      redirect_to list_path(@list)
    else  
      render :new
    end
  end


  def edit

  end

  def update
    if @task.update(task_params)
      redirect_to list_path(@list)
    else  
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to list_path(@list)
  end

  private

    def set_list
      @list = List.find(params[:list_id])
    end

    def set_task
      @task = @list.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :body)
    end
end
