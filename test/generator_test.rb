require "minitest/autorun"
require "minitest/color"
require_relative "../lib/generator"

describe Generator do
  before do
    @generator = Generator.new
    @input = {
      type: "Program",
      body: [{
        type: "ExpressionStatement",
        expression: {
          type: "CallExpression",
          callee: {
            type: "Identifier",
            name: "add"
          },
          arguments: [{
            type: "NumberLiteral",
            value: 1
          },{
            type: "NumberLiteral",
            value: 2
          }]
        }
      }]
    }

    @output = "add(1, 2)"
  end

  it "generates output for input" do
    @generator.call(@input).must_equal @output
  end
end
