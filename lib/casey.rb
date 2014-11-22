require 'rubygems'
require 'bundler/setup'

require "thor"

class CaseyCLI < Thor
    desc "format", "Formats a string using the given regex pattern"
    method_option :case, :aliases => "-c", :desc => "Specify a case type"
    def format(*args)
        return Casey.format(args[0])
    end
    default_task :time
end

module Casey
    def self.format(input)
        @words = input.scan(/[\w']+|[.,!?;]|[_ ]/)
        output = ""
        for word in @words
            output += word
        end
        parser = Parser.new(@words, input)
        return parser.parse
    end

    def self.run(args)
        CaseyCLI.start(args)
    end

    class Parser
        def initialize(words, input)
            @words = words
            @input = input
            @filter = filter_proc(/[a-z]/)
        end

        def parse
            @words = @input.scan(/[\w']+|[.,!?;]|[_ ]/).map(&:downcase).each { |word| @filter.call(word) }
            return join
        end

        def join
            return @words.join("")
        end

        def filter_proc(filter)
            if regexp_filter = Regexp.try_convert(filter)
                puts "FUCK"
                Proc.new { |word| word =~ regexp_filter }
            end
        end
    end
end
