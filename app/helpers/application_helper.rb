module ApplicationHelper
  def set_active_class(path_name)
    relative_path = public_send("#{path_name}_path")
    path_hash = Rails.application.routes.recognize_path(relative_path)
    cur_controller = path_hash[:controller]
    cur_action = path_hash[:action]
    "active" if controller_name == cur_controller && action_name == cur_action
  end
end
