# coding: utf-8

module TranslationsHelper
  def pre_translate(txt)
    txt.gsub(/起票者: /, "Added by: ").
        gsub(/ステータス: /, "Status: ").
        gsub(/優先度: /, "Priority: ").
        gsub(/カテゴリ: /, "Category: ").
        gsub(/チケット #(\d+) が更新されました。/){
          "Issue ##{$1} is updated"
        }.
        gsub(/ステータス (\w+)から(\w+)に変更/){
          "Status changed from #{$1} to #{$2}"
        }.
        gsub(/進捗 % (\d+)から(\d+)に変更/){
          "% Done changed from #{$1} to #{$2}"
        }.
        gsub(/(\d+)年(\d+)月(\d+)日(.曜日)?/){
          format "%04d-%02d-%02d ", $1, $2, $3
        }
  end
end
