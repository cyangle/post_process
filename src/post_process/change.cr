require "yaml"

class PostProcess::Change
  include YAML::Serializable
  property name : String
  property pattern : String
  property new_value : String
  property multi_line : Bool? = false

  def initialize(
    @name : String,
    @pattern : String,
    @new_value : String,
    @multi_line : Bool? = false
  )
  end

  def change(file_content : String, api_name : String)
  end
end
