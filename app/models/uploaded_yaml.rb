class UploadedYAML
  include ActiveModel::Model
  attr_accessor :file

  def yaml
    @yaml = YAML.load_file(@file.absolute_path)
  end
end
