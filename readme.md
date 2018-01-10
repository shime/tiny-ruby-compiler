# Tiny Ruby Compiler

Super tiny compiler, written in Ruby, using TDD.

100% covered with tests.

Converts Lispy expressions to C-like expressions like so:

| Operation       | Lisp                   | C                      |
| ----------------| -----------------------|------------------------|
| 1 + 1           | (add 1 1)              | add(1, 1)              |
| 4 - 2           | (subtract 4 2)         | subtract(4, 2)         |
| 2 + (4 - 2)     | (add 2 (subtract 4 2)) | add(2, subtract(4, 2)) |

Compilers generally consist of 3 main parts:
* Parsing
* Transformation
* Code Generation

## Description

### Parsing
Parsing consists of two parts:

* Lexical Analysis - takes raw code and splits it apart into tokens (check out `Tokenizer`)
* Syntactic Analysis - takes the tokens and reformats them into AST (check out `Parser`)

### Transformation
Transformation consists of two parts:

* Traverser - traverseres the original AST and operates on it (check out `Traverser`)
* Transformer - transforms the original AST to another, suited for destination lanaguage (check out `Transformer`)

### Code Generation

Code generation consists of:
* Code Generator - converts the destination AST to runnable destination code (check out `Generator`)

## Development

Install dependencies

```
bundle install
```

Run tests with
```
rake
```

## Attributions

This repo is basically a port of [thejameskyle/the-super-tiny-compiler](https://github.com/thejameskyle/the-super-tiny-compiler) to Ruby.
Definitely check it out for more thorough deep dive into compilers.

## License

MIT
