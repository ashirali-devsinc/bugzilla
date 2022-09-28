class BugsController < ApplicationController
  before_action :authorize_project_class, except: %i[show project_bug_list work_progress]
  before_action :find_bug, only: %i[edit update destroy show assign remove]
  
  def index
    @bugs = Bug.all
  end

  def new
    @bug = Bug.new
  end

  def edit; end

  def create
    @bug = Bug.new(bug_params.merge(user_id: current_user.id))

    if @bug.save
      flash[:success] = 'Bug created successfully...'
      redirect_to bugs_path
    else
      flash.now[:alert] = 'Bug not created successfully...'
      render 'new'
    end
  end

  def show; end

  def update
    @bug.assign_attributes(bug_params)
    maintain_history("Bug", @bug) unless @bug.changes.empty?
    if @bug.save
      flash[:success] = 'Bug updated successfully...'
      redirect_to bugs_path
    else
      flash.now[:alert] = 'Bug not updated successfully...'
      render 'edit'
    end
  end

  def destroy
    if @bug.destroy
      delete_history("Bug", @bug)
      flash[:alert] = 'Bug deleted successfully...'
    else
      flash[:notice] = 'Bug not deleted successfully...'
    end
    redirect_to bugs_path
  end

  def assign
    assign_bug = ProjectBug.new(bug_id: params[:id], project_id: params[:project_id])
    if assign_bug.save
      flash[:success] = 'Bug assigned successfully...'
    else
      flash[:alert] = 'Bug not assigned successfully...'
    end
  end

  def remove
    remove_bug = ProjectBug.find_by(bug_id: params[:id], project_id: params[:project_id])
    if remove_bug.destroy
      flash[:alert] = 'Bug removed successfully...'
    else
      flash[:notice] = 'Bug not removed successfully...'
    end
  end

  def project_bug_list
    render inline: '<%= render partial: "shared/index", locals: { obj: Project.find(params[:project]).bugs, model: ""} %>', layout: 'layouts/application'
  end

  def work_progress
    @project_ids = current_user.workload.pluck("project_id")
    render inline: '<%= render partial: "shared/index", locals: { obj: current_user.under_develop_bugs, model: "work_progress", project_id_array: @project_ids} %>', layout: 'layouts/application'
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :nature, :screenshot)
  end

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def authorize_project_class
    authorize Bug
  end
end
