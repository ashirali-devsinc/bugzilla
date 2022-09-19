class ProjectsController < ApplicationController
  before_action :find_project, only: %i[edit update destroy]
  
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = current_user.created_projects.create(project_params)

    if @project
      flash[:success] = 'Project created successfully...'
      redirect_to project_path(@project)
    else
      flash.now[:alert] = 'Project not created successfully...'
      render 'new'
    end
  end

  def show
    find_project
  end

  def update
    if @project.update(project_params)
      flash[:success] = 'Category updated successfully...'
      redirect_to projects_path
    else
      flash.now[:alert] = 'Category not updated successfully...'
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      flash[:alert] = 'Category deleted successfully...'
    else
      flash[:notice] = 'Category not deleted successfully...'
    end
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
