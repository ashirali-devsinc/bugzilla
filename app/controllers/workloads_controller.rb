class WorkloadsController < ApplicationController
  before_action :authorize_workload_class

  def assign_bug_to_dev
    assign_bug_to_developer = Workload.new(bug_id: params[:bug_id], user_id: current_user.id, project_id: params[:project_id])
    if assign_bug_to_developer.save
      flash[:success] = 'Bug assigned successfully...'
    else
      flash[:alert] = 'Bug not assigned successfully...'
    end
  end

  def remove_bug_from_dev
    remove_bug_from_developer = Workload.find_by(bug_id: params[:bug_id], user_id: current_user.id, project_id: params[:project_id])
    if remove_bug_from_developer.destroy
      flash[:alert] = 'Bug removed successfully...'
    else
      flash[:notice] = 'Bug not removed successfully...'
    end
  end

  def change_status
    Workload.find_by(user_id: current_user.id, bug_id: params[:bug_id], project_id: params[:project_id]).send(params[:status] + "!")
  end

  private

  def authorize_workload_class
    authorize Workload
  end
end
