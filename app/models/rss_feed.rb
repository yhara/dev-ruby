require 'rss/maker'

class RSSFeed
  include Enumerable

  class UnknownType < StandardError; end

  def initialize(type, n)
    @type, @n = type, n
  end

  def events
    case @type
    when "reader"
      events = translations(@n)
    when "translator"
      events = posts(@n) + translation_requests(@n)
    else
      raise UnknownType
    end
    events.sort_by(&:created_at).last(@n).reverse
  end

  private

  def posts(n)
    Post.
      order("number DESC").
      limit(n)
  end

  def translations(n)
    Translation.
      order("created_at DESC").
      limit(n)
  end

  def translation_requests(n)
    TranslationRequest.
      order("created_at DESC").
      limit(n)
  end

end
