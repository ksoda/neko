require_relative 'parser'

class Neko
  def nyas
    s = 'にゃ'
    s << (if rand(2).zero? then 'ー' else '〜' end) * rand(3)
    s << 'ん' if rand(2).zero?
    s
  end

  def initialize
    @parser = Parser.new
  end

  def nekonize(x)
    cs = @parser.chunks(x)
    cs.each do |c|
      idx = c.rindex(/[。、」）＞｝]/)
      if idx
        c.insert(idx, nyas)
      else
        c << nyas
      end
    end
    puts cs.join
  end
end
