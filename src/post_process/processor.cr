require "file"
require "./task.cr"

class PostProcess::Processor
  property task : Task
  property file_path : String
  property file_content : String
  property new_file_content : String = ""
  property file_name : String
  property api_name : String
  property capitalized_api_name : String

  delegate pattern, to: @task
  delegate new_value, to: @task
  delegate multi_line, to: @task

  def initialize(@task : Task, @file_path : String)
    @file_content = File.read(@file_path)
    @file_name = File.basename(@file_path)
    @api_name = @file_name.sub("_api.cr", "")
    @capitalized_api_name = @api_name.capitalize
    @new_file_content = ""
  end

  def execute
    pp "----------------------------------------------------------------"
    pp "processing file #{file_path}"
    pp "pattern_string is #{pattern_string}"
    pp "new_value_string is #{new_value_string}"
    pp "variable_hash is:"
    pp variable_hash
    @new_file_content = file_content.gsub(pattern_regex, new_value_string)
    File.write(file_path, new_file_content)
    pp "completed #{file_path}"
  end

  private def pattern_regex
    if multi_line
      /#{pattern_string}/m
    else
      /#{pattern_string}/
    end
  end

  private def pattern_string
    pattern % variable_hash
  end

  private def new_value_string
    new_value % variable_hash
  end

  private def variable_hash
    Hash{
      "api_name"             => api_name,
      "capitalized_api_name" => capitalized_api_name,
    }
  end
end
