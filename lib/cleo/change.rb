require 'yaml'
require 'json'

class Hash
  def symbolize_keys
    self.inject({}){|result, (key, value)|
      new_key = case key
                when String then key.to_sym
                else key
                end
      new_value = case value
                  when Hash then symbolize_keys(value)
                  else value
                  end
      result[new_key] = new_value
      result
    }
  end
end

module Cleo
  class Change
    attr_accessor :name, :value, :quantity

    def initialize(params)
      @name = params[:name]
      @value = params[:value]
      @quantity = params[:quantity]
    end

    def self.load
      list = []
      file_path = "#{Dir.pwd}/lib/changes.yml"
      file = YAML.load(File.open(file_path)).symbolize_keys
      file[:changes].each  do |params|
        params.symbolize_keys
        list << Change.new(params)
      end
      list
    end
  end
end
