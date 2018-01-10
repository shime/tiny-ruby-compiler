require "minitest/autorun"
require "minitest/color"
require_relative "../lib/parser"

describe Parser do
  before do
    @parser = Parser.new
  end

  {  [
      {type: "paren", value: "("},
      {type: "name", value: "add"},
      {type: "number", value: 1},
      {type: "number", value: 2},
      {type: "paren", value: ")"}
    ] => {
      type: "Program",
      body: [{
         type: "CallExpression",
         name: "add",
         params: [{
           type: "NumberLiteral",
           value: 1,
         }, {
           type: "NumberLiteral",
           value: 2,
         }]
      }]
    },
    [
      {type: "paren", value: "("},
      {type: "name", value: "upcase"},
      {type: "string", value: "foo"},
      {type: "paren", value: ")"}
    ] => {
      type: "Program",
      body: [{
         type: "CallExpression",
         name: "upcase",
         params: [{
           type: "StringLiteral",
           value: "foo",
         }]
      }]
    }

  }.each do |input, output|
    it "converts #{input} to #{output}" do
      @parser.call(input).must_equal output
    end
  end
end
