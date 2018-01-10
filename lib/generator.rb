class Generator
  class UnrecognizedNodeError < StandardError; end

  def call(node)
    case node[:type]
    when "Program"
      node[:body].map {|body| call(body)}.join("\n")
    when "ExpressionStatement"
      call(node[:expression])
    when "CallExpression"
      call(node[:callee]) + "(" + node[:arguments].map {|argument| call(argument)}.join(", ") + ")"
    when "Identifier"
      node[:name]
    when "NumberLiteral"
      node[:value]
    when "StringLiteral"
      '"' + node[:value] + "'"
    else
      raise UnrecognizedNodeError.new(node[:type])
    end
  end
end
