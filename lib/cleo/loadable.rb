module Cleo
  module Loadable
    def load
      name = "#{self.to_s.sub(/Cleo\:\:/,'').downcase}s"
      list = []
      file_path = "#{Dir.pwd}/data/#{name}.yml"
      file = YAML.load(File.open(file_path)).symbolize_keys
      file[name.to_sym].each  do |params|
        params.symbolize_keys
        list << self.new(params)
      end
      list
    end
  end
end
