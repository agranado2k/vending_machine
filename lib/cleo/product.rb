require 'yaml'
require 'json'

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
      file = YAML.load(File.open(file_path))
      file = JSON.parse(file, symbolize_names: true)
      p "file: #{file}"
      file[:products].each  do |params|
        list << Product.new(params)
      end
      list
    end
  end
end
