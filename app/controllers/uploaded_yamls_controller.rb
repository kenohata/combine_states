class UploadedYamlsController < ApplicationController
  def show
    @file = File.open("#{Rails.root}/app/models/concerns/default.yml")
    @yaml = UploadedYAML.new file: @file
    @tree = YAMLtree.load_file @file.path
  end

  def update
    @file = params[:uploaded_yaml][:file]
    @yaml = UploadedYAML.new file: @file
    @tree = YAMLtree.load_file @file.path

    render :show
  end
end
