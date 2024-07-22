class Dictionary
  attr_accessor :words

  def initialize(words_array)
    self.words = words_array
  end

  def filter
    words.select { |items| items.length.between?(6, 12) }
  end

  def random_word
    words.sample
  end
end
