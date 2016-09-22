require 'cabocha'
class Parser
  def initialize
    @parser = CaboCha::Parser.new
  end

  def parse(x)
    @parser.parse(x)
  end

  def chunks(x)
    tree = parse(x)
    str = tree.toString(CaboCha::FORMAT_LATTICE).force_encoding(Encoding::UTF_8)
    str.split("\n").chunk{|i|
      chunk_separator?(i) && :_separator
    }.map(&first_words).to_a
  end

  def chunk_separator?(line)
    line[0, 3] == 'EOS' || line[0, 2] == '* '
  end

  private

  def first_words
    proc {|i| i.last.reduce(''){|a,i| a+i.split.first} }
  end
end
