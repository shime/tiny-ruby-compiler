# Converts source AST to destination AST.
#
class Hash
  # TODO: stop doing this
  attr_accessor :_context
end

require_relative "./traverser"

class Transformer
  def call(ast)
    new_ast = {
      type: "Program",
      body: []
    }

    ast._context = new_ast[:body]

    traverser = Traverser.new(ast, {
      NumberLiteral: {
        enter: -> node, parent do
          parent._context << {
            type: "NumberLiteral",
            value: node[:value]
          }
        end
      },
      StringLiteral: {
        enter: -> node, parent do
          parent._context << {
            type: "StringLiteral",
            value: node[:value]
          }
        end
      },
      CallExpression: {
        enter: -> node, parent do 
          expression = {
            type: "CallExpression",
            callee: {
              type: "Identifier",
              name: node[:name]
            },
            arguments: []
          }

          node._context = expression[:arguments]

          if parent[:type] != "CallExpression"
            expression = {
              type: "ExpressionStatement",
              expression: expression
            }
          end

          parent._context << expression
        end
      },
    })
    traverser.call

    new_ast
  end
end
