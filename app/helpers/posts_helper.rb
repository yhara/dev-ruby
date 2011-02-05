module PostsHelper
  def format_posts(tree, &block)
    return "" if tree.empty?

    concat "<ul>".html_safe
    tree.each{|parent, children|
      concat "<li>".html_safe
      yield parent
      format_posts(children, &block)
      concat "</li>".html_safe
    }
    concat "</ul>".html_safe
  end

  def format_subject(s, opts={})
    if s =~ /\A(\[.*\])(.*)/
      tags = " <span class='redmine_tags'> - #{h $1}</span>"
      "#{h $2.lstrip}#{tags unless opts[:no_tags]}".html_safe
    else
      s
    end
  end
end
