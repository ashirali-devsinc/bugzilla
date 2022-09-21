class ApplicationController < ActionController::Base
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
    @history_maintaining_record.changes_made.delete_at(@record)
    @history_maintaining_record.save
  end

  def get_history_and_record_position(model_name, model_obj)
    @history_maintaining_record = current_user.changes_made.find_by(model: model_name)
    @record = @history_maintaining_record.changes_made.pluck(0).find_index(model_obj.id)
  end
end
