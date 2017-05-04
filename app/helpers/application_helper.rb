module ApplicationHelper

  def add_error_class(key, object)
    return "has-error" if object.errors.messages[key].present?
  end

end
