module SpringToCSharp
  class Cli

    attr_accessor :config

    def initialize
      @config = Config.new

      run
    end

    def run
      get_input_file
      get_output_file
      get_config_file
      convert
    end

    private

    def get_input_file
      puts 'Please enter a file name of a SpringFramework.net XML config to convert to a c# object (default: example.xml)'.colorize(:green)
      input_file_name = gets.chomp
      input_file_name = 'example.xml' if input_file_name.blank?

      config.input_file_name = input_file_name
    end

    def get_output_file
      default_output_file_name = config.input_file_name.gsub('xml', 'cs')
      puts "Please enter a destination file name (defaults to #{default_output_file_name})".colorize(:green)
      output_file_name = gets.chomp
      output_file_name = default_output_file_name if output_file_name.blank?

      config.output_file_name = output_file_name
    end

    def get_config_file
      puts "(Optional) Please enter the path of the config file. (defaults to #{Config::DEFAULT_FILE_NAME})".colorize(:green)
      config_file_name = gets.chomp
      config_file_name = Config::DEFAULT_FILE_NAME if config_file_name.blank?

      config.config_file_name = config_file_name
    end

    def convert
      unless conversion_confirmed?
        return puts 'Conversion Aborted'.colorize(:red)
      end

      puts 'Beginning Conversion...'.colorize(:yellow)

      converter = Converter.new(config)
      converter.convert

      puts 'Conversion Finished!'.colorize(:yellow)

    end

    def conversion_confirmed?
      puts 'Are you sure you want to convert: '
      puts "\n\t#{config.input_file_name}".colorize(:yellow)
      puts "\n\t\tto\n"
      puts "\n\t#{config.output_file_name}".colorize(:yellow)
      puts "\n\tUsing #{config.config_file_name}?".colorize(:yellow)
      puts "\nType Y or N then hit enter."


      answer = gets.chomp

      answer.downcase == 'y'
    end


  end
end
