require_relative 'parser'

class Neko
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
        c << nyas if flip_coin(2)
      end
    end
    puts cs.join
  end

  private

  def nyas
    s = 'にゃ'
    s << (if flip_coin then 'ー' else '〜' end) * rand(3)
    s << 'ん' if flip_coin
    s
  end

  def flip_coin(n=1)
    rand(2**n).zero?
  end
end
