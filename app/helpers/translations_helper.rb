# coding: utf-8

module TranslationsHelper
  def pre_translate(txt)
    txt.gsub(/起票者: /, "Added by: ").
        gsub(/ステータス: /, "Status: ").
        gsub(/優先度: /, "Priority: ")
  end
end
