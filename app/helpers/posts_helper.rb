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
end
