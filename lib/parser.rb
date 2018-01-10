# Converts tokens to AST.
#     [
#       {type: "paren", value: "("},
#       {type: "name", value: "add"},
#       {type: "number", value: 1},
#       {type: "number", value: 2},
#       {type: "paren", value: ")"}
#     ] -> {
#       type: "Program",
#       body: [{
#         type: "CallExpression",
#         name: "add",
#         params: [{
#           type: "NumberLiteral",
#           value: 1,
#         }, {
#           type: "NumberLiteral",
#           value: 2,
#         }]
#       }]
#     }

class Parser
  def initialize
    @index = 0
  end

  def call(tokens)
    @input = tokens

    ast = {
      type: "Program",
      body: []
    }

    while @index < @input.length do
      current_body = walk
      ast[:body] << current_body if current_body
    end

    ast
  end

  private

  def walk
    @current = @input[@index]

    if @current[:type] == "number"
      return process_number
    end

    if @current[:type] == "string"
      return process_string
    end

    if @current[:type] == "paren" && @current[:value] == "("
      return process_expression
    end
  end

  def process_number
    increment_index
    {
      type: "NumberLiteral",
      value: @current[:value]
    }
  end

  def process_string
    increment_index
    {
      type: "StringLiteral",
      value: @current[:value]
    }
  end

  def process_expression
    next_token # skip "("

    node = {
      type: "CallExpression",
      name: @current[:value],
      params: []
    }

    next_token # skip expression name

    while @current[:type] != "paren"
      node[:params] << walk
      @current = @input[@index]
    end

    next_token # skip ")"

    node
  end

  def next_token
    increment_index
    @current = @input[@index]
  end

  def increment_index
    @index += 1
  end
end
