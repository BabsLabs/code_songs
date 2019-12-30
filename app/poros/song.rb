class Song
  attr_reader :title, :link

  def initialize(info)
    @title = info[:title]
    @link = info[:link]
  end
end
