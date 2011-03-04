# coding: utf-8
module ApplicationHelper
  def black_star
    "★"
  end

  def white_star
    "☆"
  end

  def format_body(body)
    (detect_quotes(
      detect_svn_revisions(
        detect_ruby_ml_links(
          detect_urls(         # this should be applied first.
            h(body)))))
    ).html_safe
  end

  private

  def detect_urls(txt)
    txt.gsub(%r{https?://[A-Za-z0-9\/.~:@!\$&'\(\)%_-]+}){|match|
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
      url = "http://svn.ruby-lang.org/cgi-bin/viewvc.cgi?view=rev&revision=#{$1}"
      link_to match, url
    }
  end

  ML_NAMES = /ruby\-(?:talk|dev|core|list)/
  def detect_ruby_ml_links(txt)
    txt.gsub(/\[(#{ML_NAMES}):(\d+)\]/){|match|
      ml_name, n = $1, $2

      if ml_name == "ruby-dev"
        url = post_path(n)
        "[ruby-dev:#{link_to n, url}]"
      else
        url = "http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/#{ml_name}/#{n}"
        link_to match, url
      end
    }
  end

  QUOTE_LINE_GT = /^(&gt;)+ (.*)$/
  QUOTE_LINE_OR = /^\|(.*)$/
  QUOTE_LINE = /#{QUOTE_LINE_GT}|#{QUOTE_LINE_OR}/
  QUOTE_EMPTY = /^(&gt;)+$/
  def detect_quotes(txt)
    txt.gsub(/#{QUOTE_LINE}|#{QUOTE_EMPTY}/){|match|
      [
        "<span class='quote'>",
        match.chomp,
        "</span>"
      ].join
    }
  end
end
