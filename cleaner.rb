require 'csv'

class Cleaner
  def self.clean_data(file_path)
    cleaned_data = []
    seen_rows = {}

    CSV.foreach(file_path, headers: true) do |row|
      # Trim spaces and standardize capitalization
      cleaned_row = row.to_h.transform_values { |v| v.strip.capitalize rescue v }
      
      # Remove duplicates
      key = cleaned_row.values.join('|')
      unless seen_rows[key]
        seen_rows[key] = true
        cleaned_data << cleaned_row
      end
    end

    cleaned_data
  end

  def self.save_cleaned_data(cleaned_data, output_path)
    CSV.open(output_path, 'w', write_headers: true, headers: cleaned_data.first.keys) do |csv|
      cleaned_data.each { |row| csv << row.values }
    end
    puts "✅ Cleaned data saved to #{output_path}"
  end
end
