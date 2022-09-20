class BugsController < ApplicationController
  before_action :find_bug, only: %i[edit update destroy]
  
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

  def show
    find_bug
  end

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

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :nature)
  end

  def find_bug
    @bug = Bug.find(params[:id])
  end
end
