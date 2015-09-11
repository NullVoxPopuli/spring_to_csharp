module SpringToCSharp
  class Config

    DEFAULT_FILE_NAME = 'config.yml'
    DEFAULT_METHOD_NAME = 'MyMethod'
    DEFAULT_INDENT = '  '

    attr_accessor :input_file_name, :output_file_name, :config_file_name, :options

    def indent
      DEFAULT_INDENT
    end

    def class_name
      input_file_name.split('.').first
    end

    def method_name
      config_file['method_name'] || DEFAULT_METHOD_NAME
    end

    def substitutions
      config_file['substitutions'] || {}
    end

    def input_file
      unless @input_file
        open_file(input_file_name) do |file|
          @input_file = Nokogiri::XML(file).document
        end
      end

      @input_file
    end


    def config_file
      unless @config_file
        open_file(config_file_name) do |file|
          @config_file = YAML::load_file(file)
        end
      end

      @config_file
    end

    private

    def open_file(path)
      File.open(path, 'r') do |file|
        yield(file)
      end
    end


  end
end
