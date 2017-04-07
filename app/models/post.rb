class Post < ApplicationRecord
  scope :published, -> { where(published: true).order(date: :desc) }

  def content
    super.html_safe
  end

  def to_param
    name.gsub('.md', '')
  end
end
