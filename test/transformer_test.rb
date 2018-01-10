require "minitest/autorun"
require "minitest/color"
require_relative "../lib/transformer"

describe Transformer do
  before do
    @transformer = Transformer.new
    @ast = {
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
    }

    @new_ast = {
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
  end

  it "calls the call expression visitor" do
    @transformer.call(@ast).must_equal @new_ast
  end
end
