class Post < ApplicationRecord
  def content
    super.html_safe
  end

  def to_param
    name.gsub('.md', '')
  end
end
