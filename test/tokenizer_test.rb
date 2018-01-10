require "minitest/autorun"
require "minitest/color"
require_relative "../lib/tokenizer"

describe Tokenizer do
  before do
    @tokenizer = Tokenizer.new
  end

  { "()" => [
      {type: "paren", value: "("},
      {type: "paren", value: ")"}
    ], 
    "(  )" => [
      {type: "paren", value: "("},
      {type: "paren", value: ")"}
    ],
    "123" => [
      {type: "number", value: 123}
    ],
    '"foo"' => [
      {type: "string", value: "foo"}
    ],
    '"foo" "bar"' => [
      {type: "string", value: "foo"},
      {type: "string", value: "bar"}
    ],
    'add' => [
      {type: "name", value: "add"}
    ],
    "(add 1 2)" => [
      {type: "paren", value: "("},
      {type: "name", value: "add"},
      {type: "number", value: 1},
      {type: "number", value: 2},
      {type: "paren", value: ")"}
    ]
  }.each do |input, output|
    it "converts #{input} to #{output}" do
      @tokenizer.call(input).must_equal output
    end
  end

  it "throws for '`' as an input" do
    assert_raises(Tokenizer::InvalidCharacterError) do
      @tokenizer.call("`")
    end
  end

end
