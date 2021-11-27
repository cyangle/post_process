require "dir"
require "yaml"
require "./processor"

class PostProcess::Task
  include YAML::Serializable

  property name : String
  property file_glob : String
  property pattern : String
  property new_value : String
  property multi_line : Bool? = false

  def initialize(
    @name : String,
    @file_glob : String,
    @pattern : String,
    @new_value : String,
    @multi_line : Bool? = false
  )
  end

  def execute
    pp "processing task #{name}"
    Dir.glob(file_glob).each do |file_path|
      Processor.new(task: self, file_path: file_path).execute
    end
    pp "completed task #{name}"
  end
end
