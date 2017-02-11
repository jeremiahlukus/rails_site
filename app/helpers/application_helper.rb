module ApplicationHelper
  def is_home
    current_page?(home_url)
  end
end
