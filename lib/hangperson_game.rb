class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError, 'Please guess a letter' unless
      letter != '' && letter != nil && letter.match(/[a-z]/i)
    letter.downcase!
    if @word.include?(letter)
      if !@guesses.include?(letter)
        @guesses += letter
      else
        return false
      end
    else
      if !@wrong_guesses.include?(letter)
        @wrong_guesses += letter
      else
        return false
      end
    end
    return true
  end
  
  def word_with_guesses
    display = ''
    @word.chars.each do |x| 
      if @guesses.include? x 
        display += x
      else
        display += '-'
      end
    end
    return display
  end
  
  def check_win_or_lose
    @word.chars.each do |x|
      if !@guesses.include? x 
        if @wrong_guesses.size == 7
          return :lose
        else
          return :play
        end
      end
    end
    return :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
