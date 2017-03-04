class Post < ApplicationRecord
  def content
    super.html_safe
  end
end
