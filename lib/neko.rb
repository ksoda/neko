require 'pry'
require 'mecab'
module Neko
  def self.end_of_clause?(ms, last_ms)
    ms[0] == '記号' && ['助動詞', '動詞', '形容詞'].include?(last_ms[0])
  end

  def self.nya
    ['にゃ', 'にゃー', 'にゃ〜', 'にゃーーーー', 'にゃん', 'にゃーん', 'にゃ〜ん',
     'にゃー', 'にゃーーー', 'にゃーー' ].sample
  end

  tagger = MeCab::Tagger.new
  last_morphems = []
  while gets
    n = tagger.parseToNode($_)
    while n do
      s = n.surface
      ms = n.feature.split(',').take(2)
      print(if end_of_clause?(ms, last_morphems) then nya+s
            else s
            end)
      last_morphems = ms
      n = n.next
    end
  end
end
