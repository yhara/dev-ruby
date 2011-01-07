module MailsHelper
  def format(tree)
    return "" if tree.empty?

    "<ul>" + tree.map{|parent, children|
      "<li>#{parent.number} #{parent.subject}" + format(children) + "</li>"
    }.join("") + "</ul>"
  end
end
