require_relative "./test_helper"
require_relative "../lib/traverser"

describe Traverser do
  before do
    @count_expression_calls = 0
    @count_literal_calls = 0

    @traverser = Traverser.new({
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
    }, {
      CallExpression: {
        enter: -> node, parent { @count_expression_calls += 1 }
      },
      NumberLiteral: {
        enter: -> node, parent { @count_literal_calls += 1 }
      }
    })
  end

  it "calls the call expression visitor" do
    @traverser.call 

    @count_expression_calls.must_equal 1
  end

  it "calls the number literal visitor twice" do
    @traverser.call 

    @count_literal_calls.must_equal 2
  end
end
