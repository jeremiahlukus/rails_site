module PagesHelper
  def nav_menu_items
    [
      {title: 'About', url: home_url},
      {title: 'Events', url: home_url},
      {title: 'Calendar', url: home_url},
      {title: 'Blog', url: home_url}
    ]
  end
end
