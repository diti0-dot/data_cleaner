require 'yaml'
require 'json'

class ConfigGenerator
  def self.generate_yaml(mapping, output_path)
    File.write(output_path, mapping.to_yaml)
    puts "✅ YAML config saved to #{output_path}"
  end

  def self.generate_json(mapping, output_path)
    File.write(output_path, JSON.pretty_generate(mapping))
    puts "✅ JSON config saved to #{output_path}"
  end
end
