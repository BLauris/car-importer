module ApplicationHelper

  def add_error_class(key, object)
    return "has-error" if object.errors.messages[key].present?
  end

  def map_flash_keys(key)
    case key
    when "notice"
      "alert-success"
    when "error"
      "alert-danger"
    else
      "alert-warning"
    end
  end

end
