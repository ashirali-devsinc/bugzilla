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
    @project = Project.new(project_params.merge(creator_id: current_user.id))

    if @project.save
      flash[:success] = 'Project created successfully...'
      redirect_to projects_path
    else
      flash.now[:alert] = 'Project not created successfully...'
      render 'new'
    end
  end

  def show
    find_project
  end

  def update
    @project.assign_attributes(project_params)
    maintain_history("Project", @project) unless @project.changes.empty?
    if @project.save
      flash[:success] = 'Category updated successfully...'
      redirect_to projects_path
    else
      flash.now[:alert] = 'Category not updated successfully...'
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      delete_history("Project", @project)
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
