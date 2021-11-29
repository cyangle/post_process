require "file"
require "../change"
require "./task_processor"

class PostProcess::ChangeProcessor
  property task_processor : TaskProcessor
  property change : Change

  delegate file_path, file_name, file_content, api_name, capitalized_api_name, to: @task_processor
  delegate pattern, new_value, multi_line, to: @change

  def initialize(
    @task_processor : TaskProcessor,
    @change : Change
  )
  end

  def new_file_content
    Log.info { "Change: processing file '#{file_path}'" }
    Log.info { "Change: pattern_string is '#{pattern_string}'" }
    Log.info { "Change: new_value_string is '#{new_value_string}'" }
    Log.info { "Change: variable_hash is:" }
    Log.info { variable_hash.to_s }
    changed_file_content = file_content.gsub(pattern_regex, new_value_string)
    Log.info { "Change: completed '#{file_path}'" }
    changed_file_content
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
