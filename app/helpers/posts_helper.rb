module PostsHelper
  def post_thumbnail(post)
    return "url('#{post.thumbnail_url}')" if post.thumbnail_url
    "url('#{image_url('logo_thumbnail.png')}')"
  end
end
