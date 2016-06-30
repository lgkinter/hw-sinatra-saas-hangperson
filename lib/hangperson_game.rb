class HangpersonGame

  attr_accessor :word, :word_with_guesses, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @word_with_guesses = Array.new(@word.length, '-').join
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    if letter !~ /[a-zA-Z]/
      raise(ArgumentError)
      return false
    end
    letter = letter.downcase
    if !@guesses.include?(letter) && @word.include?(letter)
      @word.split(//).each_with_index {|ltr, i| @word_with_guesses[i] = ltr if ltr == letter}
      @guesses << letter
      return true
    elsif !@wrong_guesses.include?(letter) && !@word.include?(letter)
      @wrong_guesses << letter
      return true
    elsif @wrong_guesses.include?(letter) || @guesses.include?(letter)
      return false
    end
  end

  def check_win_or_lose
    if @word_with_guesses !~ /-/
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
