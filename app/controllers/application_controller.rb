class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @tree = YAMLtree.load_file("#{Rails.root}/app/models/concerns/default.yml")
  end

  class YAMLtree
    include Enumerable

    def self.load_file path
      tree = self.new
      tree.load_file path
      tree
    end

    def load_file path
      @yaml = YAML.load_file path
    end

    def keys
      @yaml.keys
    end

    def next_key_by key
      index = nil

      keys.each_with_index do |k, i|
        if key == k
          index = i
          break
        end
      end

      keys[index + 1]
    end

    def each_inside key
      @yaml[key].each do |state|
        if next_key = next_key_by(key)
          each_inside(next_key) { |s| yield ([state] << s).flatten }
        else
          yield state
        end
      end
    end

    def each
      each_inside(keys.first) do |state|
        yield state
      end
    end
  end
end
