# coding: utf-8
module ApplicationHelper
  def black_star
    "★"
  end

  def white_star
    "☆"
  end

  def format_body(body)
    (detect_quotes detect_svn_revisions detect_urls h(body)).html_safe
  end

  private

  def detect_urls(txt)
    txt.gsub(%r{https?://[A-Za-z0-9\/.~:@!\$&'\(\)%-]+}){|match|
      [
        "<a href='",
        match,
        "'>",
        match,
        "</a>",
      ].join
    }
  end

  def detect_svn_revisions(txt)
    txt.gsub(/r(\d+)/){|match|
      [
        "<a href='",
        "http://svn.ruby-lang.org/cgi-bin/viewvc.cgi?view=rev&revision=#{$1}",
        "'>",
        match,
        "</a>"
      ].join
    }
  end

  QUOTE_LINE = /^(&gt;)+ (.*)$/
  QUOTE_EMPTY = /^(&gt;)+$/
  def detect_quotes(txt)
    txt.gsub(/#{QUOTE_LINE}|#{QUOTE_EMPTY}/){|match|
      [
        "<span class='quote'>",
        match,
        "</span>"
      ].join
    }
  end
end
