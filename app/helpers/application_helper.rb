# coding: utf-8
module ApplicationHelper
  def black_star
    "★"
  end

  def white_star
    "☆"
  end

  def format_body(body)
   hide_redmine_ticket_description(
    detect_quotes(
    detect_redmine_ticket_numbers(
    detect_svn_revisions(
    detect_ruby_ml_links(
    detect_urls(         # this should be applied first.
      h(body))))))).html_safe
  end

  private

  def detect_urls(txt)
    txt.gsub(%r{https?://[A-Za-z0-9\/.~:@!\$&'\(\)%_-#]+}){|match|
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

  def detect_redmine_ticket_numbers(txt)
    txt.gsub(/#(\d+)/){|match|
      url = "http://redmine.ruby-lang.org/issues/#{$1}"
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

  REDMINE_DESC = %r{(.*)(----------------------------------------)(.*http://redmine.ruby-lang.org</a>\n\n)\z}m
  def hide_redmine_ticket_description(txt)
    if txt =~ REDMINE_DESC
      main, _, rest = $1, $2, $3
      bar = "---(click to toggle ticket description)---"
      "#{main}<a href='#'>\n<span class='redmine_desc_bar'>#{bar}</span></a><span class='redmine_desc'>#{rest}</span>"
    else
      txt
    end

    # see also: layouts/application
  end
end
