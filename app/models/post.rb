class Post
  REPO = 'pantherhackers/blog'.freeze
  CONFIG_LIMIT = '---'.freeze

  def initialize(f)
    raw_config, raw_content = Unirest.get(f.download_url).body.split(CONFIG_LIMIT)
    config = JSON.parse(raw_config, :symbolize_names => true)
    @author = config[:author]         # e.g. "Aimee Vu"
    @title = config[:title]           # e.g. "HackATL: Busy Making Businesses!"
    @date = DateTime.iso8601(config[:date])       # ISO 8601 format e.g. "2017-02-15T04:24:38+00:00"
    @tags = config[:tags]             # e.g. "learning", "hackathons", "events"
    @published = config[:published]   # e.g. true, false
    @content = raw_content
  end

  def self.all
    Octokit.contents(REPO).reject { |f| f.name == 'README.md' }.map { |f| Post.new(f) }
  end
end
