# Tiny Ruby Compiler

Super tiny compiler, written in Ruby, using TDD. 

100% covered with tests.

Converts Lisp to C like so:

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
Parsing is consisted of two parts:

* Lexical Analysis - takes raw code and splits it apart into tokens (check out `Tokenizer`)
* Syntactic Analysis - takes the tokens and reformats them into AST (check out `Parser`)

### Transformation
### Code Generation

## Attributions

This repo is basically a port of [thejameskyle/the-super-tiny-compiler](https://github.com/thejameskyle/the-super-tiny-compiler) to Ruby.
Definitely check it out for more thorough deep dive into compilers.

## License

MIT
