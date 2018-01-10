# Converts source code to tokens
#
# (add 1, 2) => [{type: 'paren', value: '('}, ...]
#
class Tokenizer
  PAREN = /\(|\)/
  NUMBER = /[0-9]/
  DOUBLEQUOTE = /"/
  LETTER = /[a-z]/
  WHITESPACE = /\s/

  class InvalidCharacterError < StandardError; end

  def initialize
    @index = 0
    @tokens = []
  end

  def call(raw)
    @input = raw.split('')

    while @index < @input.length do
      @char = @input[@index]

      process_char
    end

    @tokens
  end

  private

  def process_char
    case @char
    when PAREN
      process_paren
    when WHITESPACE
      process_whitespace
    when NUMBER
      process_number
    when DOUBLEQUOTE
      process_string
    when LETTER
      process_name
    else
      fail InvalidCharacterError.new
    end
  end

  def process_paren
    @tokens << {
      type: "paren", value: @char
    }

    next_char
  end

  def process_whitespace
    @index += 1
  end

  def process_number
    value = ''

    while @char =~ NUMBER
      value << @char

      next_char
    end

    @tokens << {type: 'number', value: value.to_i}
  end

  def process_string
    value = ''

    next_char

    while @char && @char !~ DOUBLEQUOTE
      value << @char

      next_char
    end

    next_char

    @tokens << {type: "string", value: value}
  end

  def process_name
    value = ''

    while @char =~ LETTER
      value << @char
      next_char
    end

    @tokens << {type: "name", value: value}
  end

  def next_char
    @index += 1
    @char = @input[@index]
  end
end
