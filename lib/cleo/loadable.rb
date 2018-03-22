module Cleo
  module Loadable
    def load
      name = "#{self.to_s.sub(/Cleo\:\:/,'').downcase}s"
      file_path = "#{Dir.pwd}/data/#{name}.yml"
      file = YAML.load(File.open(file_path)).symbolize_keys
      file[name.to_sym].reduce({}) do |r, params|
        params = params.symbolize_keys
        r[params[:value]] =  self.new(params)
        r
      end
    end
  end
end
