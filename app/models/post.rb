class Post
  REPO = 'pantherhackers/blog'.freeze
  CONFIG_LIMIT = '---'.freeze
  RAW_GH = 'https://raw.githubusercontent.com/PantherHackers/blog/master/'.freeze
  IGNORED = ['README.md', '.gitignore']

  attr_reader :name, :author, :title, :thumbnail, :date, :tags, :published, :content, :url

  def initialize(f)
    raw_config, raw_content = Unirest.get(f.download_url).body.split(CONFIG_LIMIT)
    config = JSON.parse(raw_config, :symbolize_names => true)
    @name = f.name                                                  # e.g "hackatl-busy-making-businesses"
    @author = config[:author]                                       # e.g. "Aimee Vu"
    @title = config[:title]                                         # e.g. "HackATL: Busy Making Businesses!"
    @thumbnail = "#{RAW_GH}images/#{config[:thumbnail]}".freeze if config[:thumbnail] # e.g. "pic.jpg"
    @date = DateTime.iso8601(config[:date])                         # ISO 8601 format e.g. "2017-02-15T04:24:38+00:00"
    @tags = config[:tags]                                           # e.g. "learning", "hackathons", "events"
    @published = config[:published]                                 # e.g. true, false
    @content = raw_content
    @url = "blog/#{@name}".freeze
  end

  def self.all
    Octokit.contents(REPO).reject { |f| IGNORED.include?(f.name) || f.type != 'file' }.map { |f| Post.new(f) }
  end
end
