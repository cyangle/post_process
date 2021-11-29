require "dir"
require "yaml"
require "./change"
require "./processors/task_processor"

class PostProcess::Task
  include YAML::Serializable

  property name : String
  property file_glob : String
  property changes : Array(Change)

  def initialize(
    @name : String,
    @file_glob : String,
    @changes : Array(Change)
  )
  end

  def execute
    Log.info { "processing task #{name}\n" }
    Dir.glob(file_glob).each_with_index do |file_path, index|
      Log.info { "\n\n" } unless index == 0
      TaskProcessor.new(task: self, file_path: file_path).execute
    end
    Log.info { "completed task #{name}" }
  end
end
