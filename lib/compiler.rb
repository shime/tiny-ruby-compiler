require_relative "./tokenizer"
require_relative "./parser"
require_relative "./transformer"
require_relative "./generator"

# Converts (add 1 2) => add(1, 2) by
# calling every component of the pipeline.

class Compiler
  def call(input)
    tokens  = Tokenizer.new.call(input)
    ast     = Parser.new.call(tokens)
    new_ast = Transformer.new.call(ast)
    output  = Generator.new.call(new_ast)

    output
  end
end
