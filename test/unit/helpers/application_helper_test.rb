require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def test_detect_urls
    before = "see also: http://example.com/"
    after  = "see also: <a href='http://example.com/'>http://example.com/</a>" 
    assert_equal after, detect_urls(before)
  end

  def test_detect_svn_revisions
    before = "changed in r12345"
    after  = "changed in <a href=\"http://svn.ruby-lang.org/cgi-bin/viewvc.cgi?view=rev&amp;revision=#{12345}\">r12345</a>"
    assert_equal after, detect_svn_revisions(before)
  end

  def test_detect_redmine_ticket_numbers
    before = "Bug #9876"
    after  = "Bug <a href=\"http://redmine.ruby-lang.org/issues/#{9876}\">#9876</a>"
    assert_equal after, detect_redmine_ticket_numbers(before)
  end

  def test_detect_ruby_ml_links
    before = "in [ruby-core:12345]"
    after  = "in <a href=\"http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/12345\">[ruby-core:12345]</a>"
    assert_equal after, detect_ruby_ml_links(before)
  end

  def test_detect_quote_by_angle_bracket
    before = "&gt; hello"
    after  = "<span class='quote'>&gt; hello</span>"
    assert_equal after, detect_quotes(before)
  end

  def test_detect_quote_by_pipe
    before = "| hello"
    after  = "<span class='quote'>| hello</span>"
    assert_equal after, detect_quotes(before)
  end
end
