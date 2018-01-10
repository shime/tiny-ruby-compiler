require "minitest/autorun"
require "minitest/color"
require_relative "../lib/compiler"

describe Compiler do
  before do
    @compiler = Compiler.new
  end
  {
    "(add 1 2)" => "add(1, 2)",
    "(add 1 (subtract 4 2))" => "add(1, subtract(4, 2))"
  }.each do |input, output|
    it "converts #{input} to #{output}" do
      @compiler.call(input).must_equal output
    end
  end
end
