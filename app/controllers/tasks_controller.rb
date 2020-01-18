class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :destroy]

  def index
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def show
      @tasks = Task.find(params[:id])
  end

  def new
      @tasks = Task.new
  end

  def create
      @tasks = current_user.tasks.build(task_params)
      if @tasks.save
          flash[:success] = 'Taskが正常に登録されました'
          redirect_to @tasks
      else 
          @task = current_user.tasks.order(id: :desc).page(params[:page])
          flash.now[:danger]= 'Taskが正常に登録されませんでした'
          render :new
      end
  end

  def edit
      @tasks = Task.find(params[:id])
  end

  def update
       @tasks = Task.find(params[:id])

    if @tasks.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
      
  end

  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
      
  end
  
  private
  
  # Strong Parameter
  
      
  def task_params
      params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end
  
  
end