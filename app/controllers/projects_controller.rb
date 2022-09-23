class ProjectsController < ApplicationController
  before_action :find_project, only: %i[edit update destroy]
  before_action :required_ids, only: %i[assign_dev assign_qa remove_dev remove_qa]
  
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
      flash[:success] = 'Project updated successfully...'
      redirect_to projects_path
    else
      flash.now[:alert] = 'Project not updated successfully...'
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      delete_history("Project", @project)
      flash[:alert] = 'Project deleted successfully...'
    else
      flash[:notice] = 'Project not deleted successfully...'
    end
    redirect_to projects_path
  end

  def developers_list
    @developers = User.developer
  end

  def QAs_list
    @QAs = User.QA
  end

  def assign_dev
    assign_dev = ProjectDeveloper.new(user_id: params[:user_id], project_id: params[:id])
    if assign_dev.save
      flash[:success] = 'Developer assigned successfully...'
    else
      flash[:alert] = 'Developer not assigned successfully!!!'
    end
  end

  def assign_qa
    assign_qa = ProjectQa.new(user_id: params[:user_id], project_id: params[:id])
    if assign_qa.save
      flash[:success] = 'QA assigned successfully...'
    else
      flash[:alert] = 'QA not assigned successfully!!!'
    end
  end

  def remove_dev
    remove_dev = ProjectDeveloper.find_by(user_id: @user_id, project_id: @project_id)
    if remove_dev.destroy
      flash[:alert] = 'Developer un-assigned successfully...'
    else
      flash[:notice] = 'Developer not un-assigned successfully...'
    end
  end

  def remove_qa
    remove_qa = ProjectQa.find_by(user_id: @user_id, project_id: @project_id)
    if remove_qa.destroy
      flash[:alert] = 'QA un-assigned successfully...'
    else
      flash[:notice] = 'QA not un-assigned successfully...'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def required_ids
    @user_id = params[:user_id]
    @project_id = params[:id]
  end
end
