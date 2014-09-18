class UploadedYamlsController < ApplicationController
  def show
    @file     = File.open("#{Rails.root}/app/models/concerns/default.yml")
    @tree     = YAMLtree.load_file @file.path
    @uploaded = UploadedYAML.new file: @file
  end

  def update
    @file     = params[:uploaded_yaml][:file]
    @tree     = YAMLtree.load_file @file.path
    @uploaded = UploadedYAML.new file: @file

    render :show
  end
end
