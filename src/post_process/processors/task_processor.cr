require "file"
require "../task"
require "./change_processor"

class PostProcess::TaskProcessor
  property task : Task
  property file_path : String
  property file_name : String
  property file_content : String
  property api_name : String
  property capitalized_api_name : String

  delegate changes, to: @task

  def initialize(@task : Task, @file_path : String)
    @file_name = File.basename(@file_path)
    @file_content = File.read(@file_path)
    @api_name = @file_name.sub("_api.cr", "")
    @capitalized_api_name = @api_name.split("_").map(&.capitalize).join
  end

  def execute
    Log.info { "∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧∧" }
    Log.info { "Task: processing '#{task.name}' for '#{file_path}'" }
    Log.info { "----------------------------------------------------------------" }
    apply_changes_to_file_content
    File.write(file_path, file_content)
    Log.info { "----------------------------------------------------------------" }
    Log.info { "Task: completed '#{task.name}' for '#{file_path}'" }
    Log.info { "∨vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv" }
  end

  def apply_changes_to_file_content
    changes.each do |change|
      Log.info { "================================================================" }
      Log.info { "Change: processing '#{change.name}'" }
      Log.info { "================================================================" }
      new_file_content = ChangeProcessor.new(task_processor: self, change: change).new_file_content
      @file_content = new_file_content
      Log.info { "================================================================" }
      Log.info { "Change: completed '#{change.name}'" }
      Log.info { "================================================================" }
    end
  end
end
