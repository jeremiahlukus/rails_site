module ApplicationHelper
  def home?
    current_page?(home_url)
  end

  def nav_menu_items
    [
      {title: 'Blog', url: blog_url},
      {title: 'Events', url: calendar_url},
      {title: 'About', url: about_url}
    ]
  end

  def social_menu_items
    [
      { icon: 'fa-facebook', url: 'https://www.facebook.com/PantherHackers' },
      { icon: 'fa-twitter', url: 'https://twitter.com/PantherHackers' },
      { icon: 'fa-instagram', url: 'https://instagram.com/pantherhackers/' },
      { icon: 'fa-github', url: 'https://github.com/pantherhackers' },
      { icon: 'fa-slack', url: 'https://pantherhackers.slack.com' },
      { icon: 'fa-envelope-o', url: 'mailto:hello@pantherhackers.com' }
    ]
  end
end
