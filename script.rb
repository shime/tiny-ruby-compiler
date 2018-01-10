class Transformer
  def call(ast)
    new_ast = {
      type: "Program",
      body: []
    }

    traverser = Traverser.new
    traverser.call(ast, {
    })
  end
end

hash = {
  NumberLiteral: -> { 
    {
      enter: -> {
      }
    }
  }
}

p hash[:NumberLiteral].call
