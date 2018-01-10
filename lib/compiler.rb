require_relative "./tokenizer"
require_relative "./parser"
require_relative "./transformer"
require_relative "./generator"

class Compiler
  def call(input)
    tokens = Tokenizer.new.call(input)
    ast = Parser.new.call(tokens)
    new_ast = Transformer.new.call(ast)
    output = Generator.new.call(new_ast)

    output
  end
end
