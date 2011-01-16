module PostsHelper
  def format_posts(tree, &block)
    return "" if tree.empty?

    ("<ul>" + tree.map{|parent, children|
      [
        "<li>",
        format_post(parent),
        format_posts(children, &block),
        "</li>"
      ].join
    }.join + "</ul>").html_safe
  end

  def format_post(post)
    if post.is_root?
      link_text = "#{h post.number} #{h post.translation_subject} : #{h post.from}".html_safe
      link_path = post_path(post)
    else
      link_text = "#{h post.number} : #{h post.from}".html_safe
      link_path = post_path(post.root, :anchor => post.number)
    end

    if post.translation
      klass = "translated"
    else
      klass = "not_translated"
    end

    [
      "<div class='#{klass}'>",
      (link_to link_text, link_path),
      "</div>"
    ].join
  end
end
