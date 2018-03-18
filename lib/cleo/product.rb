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
  class Product
    attr_accessor :name, :price, :quantity

    def initialize(params)
      @name = params[:name]
      @price = params[:price]
      @quantity = params[:quantity]
    end

    def self.load
      list = []
      file_path = "#{Dir.pwd}/lib/products.yml"
      file = YAML.load(File.open(file_path)).symbolize_keys
      file[:products].each  do |params|
        params.symbolize_keys
        list << Product.new(params)
      end
      list
    end
  end
end
