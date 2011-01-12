module MailsHelper
  def format_mails(tree, &block)
    return "" if tree.empty?

    ("<ul>" + tree.map{|parent, children|
      "<li>" + format_mail(parent) + format_mails(children, &block) + "</li>"
    }.join("") + "</ul>").html_safe
  end

  def format_mail(mail)
    if mail.parent
      path = mail_path(mail.root, :anchor => mail.number)
    else
      path = mail_path(mail)
    end
    tr = if mail.translations.empty? then "" else "*" end
    link_to "#{h mail.number} #{h mail.subject} #{tr}", path
  end
end
