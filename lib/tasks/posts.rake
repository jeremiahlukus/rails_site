namespace :posts do

  desc "Pulls posts from Github and stores them in our AWS database"
  task import: :environment do
    REPO = 'pantherhackers/blog'.freeze
    CONFIG_LIMIT = '---'.freeze
    RAW_GH = 'https://raw.githubusercontent.com/PantherHackers/blog/master'.freeze
    IMG_DIR = "#{RAW_GH}/images".freeze
    IGNORED = ['README.md', '.gitignore']

    data = Octokit.contents(REPO, access_token: Rails.application.secrets.github_api_key)

    data.reject { |f| IGNORED.include?(f.name) || f.type != 'file' }.map do |incomplete_post_json|

      post_json = Octokit.contents(REPO, access_token: Rails.application.secrets.github_api_key, path: incomplete_post_json.name)

      raw_config, raw_content = Base64.decode64(post_json.content).split(CONFIG_LIMIT)
      config = JSON.parse(raw_config, :symbolize_names => true)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

      post = Post.create(
        name: post_json.name,
        author: config[:author],
        title: config[:title],
        thumbnail_url: config[:thumbnail] ? "#{IMG_DIR}/#{config[:thumbnail]}" : nil,
        date: DateTime.iso8601(config[:date]),
        tags: config[:tags].join(','),
        published: config[:published],
        content: markdown.render(raw_content).html_safe
      )
    end
  end

end
