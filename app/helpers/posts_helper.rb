module PostsHelper
  def post_thumbnail(post)
    return "url('#{post.thumbnail}')" if post.thumbnail
    "url('#{image_url('logo_thumbnail.png')}')"
  end
end
