module ApplicationHelper
  def top_page?
    controller_name == "home" && action_name == "index"
  end
end
