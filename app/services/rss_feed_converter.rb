class RssFeedConverter
  attr_reader :feed

  def self.execute(url)
    xml = Faraday.get(url).body
    feed = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
    new(feed)
  end

  def initialize(feed)
    @feed = feed
  end

  def episodes
    feed.entries.map { |entry| RssFeedEpisode.new(entry) }
  end

end

class RssFeedEpisode
  alias :read_attribute_for_serialization :send
  attr_accessor :entry
  delegate :title, to: :entry
  delegate :published, to: :entry
  alias_attribute :published_at, :published
  delegate :summary, to: :entry
  alias_attribute :description, :summary
  delegate :itunes_duration, to: :entry
  alias_attribute :duration_time, :itunes_duration

  def initialize(entry)
    @entry = entry
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end
