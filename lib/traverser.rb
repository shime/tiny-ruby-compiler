# Traverses source AST given.
#
class Traverser
  class UnrecognizedNodeError < StandardError; end

  def initialize(ast, visitor)
    @ast = ast
    @visitor = visitor
  end

  def call
    traverse_node(@ast, nil)
  end

  def traverse_array(array, parent)
    array.each do |child|
      traverse_node(child, parent)
    end
  end

  def traverse_node(node, parent)
    methods = @visitor[node[:type].to_sym]

    if methods && methods[:enter]
      methods[:enter].call(node, parent)
    end

    case node[:type]
    when "Program"
      traverse_array(node[:body], node)
    when "CallExpression"
      traverse_array(node[:params], node)
    when "StringLiteral", "NumberLiteral"
    else
      fail UnrecognizedNodeError.new(node[:type])
    end
  end
end
