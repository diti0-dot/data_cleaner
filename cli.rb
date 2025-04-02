require 'thor'
require_relative 'cleaner'
require_relative 'config_generator'

class CLI < Thor
  desc "clean FILE", "Clean a CSV file and remove duplicates"
  def clean(file)
    cleaned_data = Cleaner.clean_data(file)
    output_path = "cleaned_#{File.basename(file)}"
    Cleaner.save_cleaned_data(cleaned_data, output_path)
  end

  desc "map FILE", "Manually map fields and generate YAML/JSON"
  def map(file)
    cleaned_data = Cleaner.clean_data(file)
    sample_row = cleaned_data.first

    puts "Detected fields: #{sample_row.keys.join(', ')}"
    mapping = {}
    
    sample_row.keys.each do |field|
      print "Rename '#{field}' to (press Enter to keep the same): "
      new_field = STDIN.gets.chomp
      mapping[field] = new_field.empty? ? field : new_field
    end

    puts "Choose format: (1) YAML (2) JSON"
    choice = STDIN.gets.chomp.to_i

    output_path = "config.#{choice == 1 ? 'yaml' : 'json'}"
    choice == 1 ? ConfigGenerator.generate_yaml(mapping, output_path) : ConfigGenerator.generate_json(mapping, output_path)
  end
end

CLI.start(ARGV)
