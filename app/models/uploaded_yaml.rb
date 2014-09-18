class UploadedYAML
  include ActiveModel::Model
  attr_accessor :file

  def yaml
    @yaml = YAML.load_file(@file.path)
  end

  def value_array?
    yaml.map{|k, v| Array === v }.all?
  end

  def value_hash?
    yaml.map{|k, v| Hash === v }.all?
  end

  def sub_value_array?
    if value_hash?
      yaml.map{|k, v| v.map{|k, v| Array === v }.flatten }.all?
    end
  end

  def single_model?
    value_array?
  end

  def multi_model?
    (! value_array?) and value_hash? and sub_value_array?
  end
end
