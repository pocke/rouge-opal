require 'pathname'
require 'tsort'

task :compile do
  sh "opal -I lib/ -c --gem rouge -r thread -r rouge lib/main.rb > public/index.js"
end

namespace :generate do
  task :require_lexers do
    root_path = Pathname(File.expand_path('~/ghq/github.com/rouge-ruby/rouge'))
    lexers = root_path.glob('lib/rouge/lexers/**/*.rb').map do |path|
      name = path.to_s[%r!lib/rouge/lexers/(.+$)!, 1]
      children = path.read.lines.grep(/load_lexer/).map{|l| l[/["'](.+)["']/, 1]}

      # To avoid "superclass mismatch for class Xxx"
      [
        %w[lua builtins],
        %w[mathematica builtins],
        %w[matlab builtins],
        %w[php builtins],
        %w[gherkin keywords],
        %w[viml keywords],
      ].each do |lang, sub|
        if name == "#{lang}/#{sub}.rb"
          children << "#{lang}.rb"
        end
      end


      [
        name,
        children,
      ]
    end.to_h.reject do |k, _|
      # They requires yaml, and yaml does not works well. So reject them.
      k == 'apache.rb' || k == 'lasso.rb'
    end

    sorted = TSort.tsort(
      -> (&b) { lexers.each_key(&b) },
      -> (n, &b) { lexers[n].each(&b) }
    )

    content = sorted.map { |name| "require 'rouge/lexers/#{name.sub('.rb', '')}'"}.join("\n")
    File.write('lib/require_lexers.rb', content)
  end
end

task default: [:'generate:require_lexers', :compile]
