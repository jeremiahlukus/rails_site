class Post
  REPO = 'pantherhackers/blog'.freeze
  CONFIG_LIMIT = '---'.freeze
  RAW_GH = 'https://raw.githubusercontent.com/PantherHackers/blog/master'.freeze
  IMG_DIR = "#{RAW_GH}/images"
  IGNORED = ['README.md', '.gitignore']

  attr_reader :name, :author, :title, :thumbnail, :date, :tags, :published, :content, :url

  def initialize(post_json)
    raw_config, raw_content = Base64.decode64(post_json.content).split(CONFIG_LIMIT)
    config = JSON.parse(raw_config, :symbolize_names => true)
    @name = post_json.name                                                  # e.g "hackatl-busy-making-businesses"
    @author = config[:author]                                       # e.g. "Aimee Vu"
    @title = config[:title]                                         # e.g. "HackATL: Busy Making Businesses!"
    @thumbnail = "#{IMG_DIR}/#{config[:thumbnail]}".freeze if config[:thumbnail] # e.g. "pic.jpg"
    @date = DateTime.iso8601(config[:date])                         # ISO 8601 format e.g. "2017-02-15T04:24:38+00:00"
    @tags = config[:tags]                                           # e.g. "learning", "hackathons", "events"
    @published = config[:published]                                 # e.g. true, false
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @content = markdown.render(raw_content)
    @url = "/blog/#{@name}".freeze
  end

  def self.all
    Post.pull_gh_data.reject { |f| IGNORED.include?(f.name) || f.type != 'file' }.map do |post_json|
      Post.new(Post.pull_gh_data("#{post_json.name}"))
    end
  end

  def self.find(name)
    Post.new(Post.pull_gh_data("#{name}.md"))
  end

  def self.pull_gh_data(path=nil)
    Octokit.contents(REPO, access_token: Rails.application.secrets.github_api_key, path: path)
  end
end
