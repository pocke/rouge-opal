# stdlib
require 'pathname'

# The containing module for Rouge
module Rouge
  class << self
    def reload!
      Object.send :remove_const, :Rouge
      load __FILE__
    end

    # Highlight some text with a given lexer and formatter.
    #
    # @example
    #   Rouge.highlight('@foo = 1', 'ruby', 'html')
    #   Rouge.highlight('var foo = 1;', 'js', 'terminal256')
    #
    #   # streaming - chunks become available as they are lexed
    #   Rouge.highlight(large_string, 'ruby', 'html') do |chunk|
    #     $stdout.print chunk
    #   end
    def highlight(text, lexer, formatter, &b)
      lexer = Lexer.find(lexer) unless lexer.respond_to? :lex
      raise "unknown lexer #{lexer}" unless lexer

      # XXX: maybe opal bug, `string.respond_to? :format` returns true in Opal.
      # formatter = Formatter.find(formatter) unless formatter.respond_to? :format
      formatter = Formatter.find(formatter)
      raise "unknown formatter #{formatter}" unless formatter

      formatter.format(lexer.lex(text), &b)
    end
  end
end

require 'rouge/version'
require 'rouge/util'
require 'rouge/text_analyzer'
require 'rouge/token'

require 'rouge/lexer'
require 'rouge/regex_lexer'
require 'rouge/template_lexer'

module Rouge
  module Lexers
    def self.load_lexer(_)
      # ignore
    end
  end
end

require 'require_lexers'

require 'rouge/guesser'
require 'rouge/guessers/util'
require 'rouge/guessers/glob_mapping'
require 'rouge/guessers/modeline'
require 'rouge/guessers/filename'
require 'rouge/guessers/mimetype'
require 'rouge/guessers/source'
require 'rouge/guessers/disambiguation'

require 'rouge/formatter'
require 'rouge/formatters/html'
require 'rouge/formatters/html_table'
require 'rouge/formatters/html_pygments'
require 'rouge/formatters/html_legacy'
require 'rouge/formatters/html_linewise'
require 'rouge/formatters/html_line_table'
require 'rouge/formatters/html_inline'
require 'rouge/formatters/terminal256'
require 'rouge/formatters/tex'
require 'rouge/formatters/null'

require 'rouge/theme'
require 'rouge/tex_theme_renderer'
require 'rouge/themes/thankful_eyes'
require 'rouge/themes/colorful'
require 'rouge/themes/base16'
require 'rouge/themes/github'
require 'rouge/themes/igor_pro'
require 'rouge/themes/monokai'
require 'rouge/themes/molokai'
require 'rouge/themes/monokai_sublime'
require 'rouge/themes/gruvbox'
require 'rouge/themes/tulip'
require 'rouge/themes/pastie'
require 'rouge/themes/bw'
require 'rouge/themes/magritte'
