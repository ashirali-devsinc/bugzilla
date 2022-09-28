class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from Module::DelegationError, with: :user_not_authorize
  rescue_from ActiveRecord::StatementInvalid, with: :fields_required

  def maintain_history(model_name, model_obj)
    get_history_and_record_position(model_name, model_obj)
    @history_maintaining_record.changes_made.empty? ? initailize_history(@history_maintaining_record, model_obj) : 
    (@record ? maintaining_history(@history_maintaining_record, @record, model_obj) : initailize_history(@history_maintaining_record, model_obj) )
    @history_maintaining_record.save
  end

  def initailize_history(history_maintaining_record, model_obj)
    history_maintaining_record.changes_made.push([model_obj.id, [model_obj.changes]])
  end

  def maintaining_history(history_maintaining_record, record, model_obj)
    history_maintaining_record.changes_made[record][1].push(model_obj.changes)
  end

  def delete_history(model_name, model_obj)
    get_history_and_record_position(model_name, model_obj)
    return if @history_maintaining_record.nil?
    @history_maintaining_record.changes_made.delete_at(@record)
    @history_maintaining_record.save
  end

  def get_history_and_record_position(model_name, model_obj)
    @history_maintaining_record = current_user.changes_made.find_by(model: model_name)
    return if @history_maintaining_record.nil?
    @record = @history_maintaining_record.changes_made.pluck(0).find_index(model_obj.id)
  end

  private

  def user_not_authorized(_exception)
    flash[:alert] = 'You are not authorized to perform this action!'
    redirect_to root_path
  end

  def record_not_found
    flash[:alert] = 'Record not fund!'
    redirect_to root_path
  end

  def record_invalid
    flash[:alert] = 'Record is invalid!'
    redirect_to root_path
  end

  def user_not_authorize
    flash[:alert] = 'You are not an authorize user!'
    redirect_to root_path
  end

  def fields_required
    flash[:alert] = 'Please fill out the required fields!'
    redirect_to root_path
  end
end
