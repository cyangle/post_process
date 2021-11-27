require "yaml"
require "./task"

class PostProcess::Configuration
  include YAML::Serializable

  PATH = ".post_process.yml"

  property tasks : Array(Task)?

  def initialize(@tasks : Array(Task))
  end

  def self.load(path : String = PATH)
    raise RuntimeError.new("Configuration file #{path} does not exist!") unless File.exists?(path)

    from_yaml(File.read(path))
  end
end
