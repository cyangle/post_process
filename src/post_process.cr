require "option_parser"
require "./post_process/configuration.cr"

module PostProcess
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify }}

  extend self

  def run(args = ARGV)
    opts = parse_args(args)
    config = Configuration.load(opts.config)
    tasks = config.tasks

    return puts "No tasks found" if tasks.nil? || tasks.empty?

    puts "Found #{tasks.size} tasks"
    tasks.each(&.execute)
  end

  private class Opts
    property config = Configuration::PATH
  end

  def parse_args(args, opts = Opts.new)
    OptionParser.parse(args) do |parser|
      parser.banner = "Usage: post_process [options]"

      parser.on("-v", "--version", "Print version") { print_version }
      parser.on("-h", "--help", "Show this help") { print_help(parser) }

      parser.on("-c", "--config PATH",
        "Specify a configuration file") do |path|
        opts.config = path unless opts.config.empty?
      end
    end

    opts
  end

  private def print_version
    puts VERSION
    exit 0
  end

  private def print_help(parser)
    puts parser
    exit 0
  end
end
