module MailsHelper
  def format_mails(tree, &block)
    return "" if tree.empty?

    ("<ul>" + tree.map{|parent, children|
      [
        "<li>",
        format_mail(parent),
        format_mails(children, &block),
        "</li>"
      ].join
    }.join + "</ul>").html_safe
  end

  def format_mail(mail)
    if mail.is_root?
      link_text = "#{h mail.number} #{h mail.translation_subject} : #{h mail.from}".html_safe
      link_path = mail_path(mail)
    else
      link_text = "#{h mail.number} : #{h mail.from}".html_safe
      link_path = mail_path(mail.root, :anchor => mail.number)
    end

    if mail.translation
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
