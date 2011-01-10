module MailsHelper
  def format_mails(tree, &block)
    return "" if tree.empty?

    ("<ul>" + tree.map{|parent, children|
      "<li>" + format_mail(parent) + format_mails(children, &block) + "</li>"
    }.join("") + "</ul>").html_safe
  end

  def format_mail(mail)
    if mail.parent
      path = mail_path(mail.root.number, :anchor => mail.number)
    else
      path = mail_path(mail.number)
    end
    link_to "#{h mail.number} #{h mail.subject}", path
  end
end
