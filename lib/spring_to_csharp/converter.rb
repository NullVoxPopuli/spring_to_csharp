module SpringToCSharp
  class Converter

    attr_accessor :config, :nokogiri_document, :substitution_hash, :return_type

    def initialize(config)
      @config = config
      @nokogiri_document = config.input_file
      @substitution_hash = config.substitutions
    end

    def convert
      csharp = to_csharp_string(nokogiri_document)
      csharp = apply_template(Templates::CSHARP_CLASS, csharp)
      write_output(csharp)
    end

    private

    def to_csharp_string(xml)

      tag_name = tag_name_of_node(xml)

      result = ''

      case tag_name
      when TagNames::TEXT
        result
      when TagNames::OBJECTS, TagNames::DOCUMENT
        # this is an overall containing element for a spring config file
        array_to_csharp_string(xml.children)
      when TagNames::OBJECT
        klass = klass_from_node(xml)
        # set the return type only once
        @return_type = klass unless @return_type.present?

        result << "new #{klass}("

        if xml.respond_to?(:children)
          result << array_to_csharp_string(xml.children)
        end

        result << ')'
      when TagNames::LIST
        children = xml.children
        type_of_list = get_type_of_list(children)

        result << "new List<#{type_of_list}>(){"
        result << array_to_csharp_string(children)
        result << "}"
      when TagNames::PARAMETER
        name = name_from_node(xml)

        # use the named parameter format of
        # parameter: value
        result << "#{name}: "

        # the parameter will either have a value, or have childern
        if value = value_from_node(xml)
          # NOTE: if there are multiple parameters, we don't worry about
          #       the trailing comma here. That's the caller's job

          if substitution_hash.has_key?(value)
            value = substitution_hash[value]
          end

          result << value
        elsif xml.respond_to?(:children)
          result << array_to_csharp_string(xml.children)
        end
      else
        raise "unrecognized tag name: #{tag_name}"
      end
    end

    def array_to_csharp_string(xml_array)
      xml_array.map { |node|
        to_csharp_string(node)
      }.select { |n| !n.blank? }.join(', ')
    end

    def get_type_of_list(node)
      first_object = node.select { |n|
        tag_name_of_node(n) == TagNames::OBJECT
      }.first

      klass_from_node(first_object)
    end

    def klass_from_node(node)
      type = type_from_node(node)
      type_to_klass(type)
    end

    #
    # Converts
    #   ScaanCompute.Common.Model.Processes
    #     .TransmissionOutputPerformance.EngineConverterMatch
    #     .EngineConverterMatchPowerSource, ScaanCompute.Common
    # to
    #   EngineConverterMatchPowerSource
    #
    def type_to_klass(spring_type)
      without_project = spring_type.split(',')
      namespaced_type = without_project.first
      namespaced_type.split('.').last
    end

    def type_from_node(node)
      node[SpringKeys::TYPE]
    end

    def value_from_node(node)
      node[SpringKeys::VALUE]
    end

    def name_from_node(node)
      node[SpringKeys::NAME]
    end

    def tag_name_of_node(node)
      node.try(:name) || node.try(:node_name)
    end

    def apply_template(template, body)
      class_name = config.class_name
      method_name = config.method_name

      template.call(
        class_name,
        method_name,
        return_type,
        body
      )
    end

    def write_output(text)
      File.open(config.output_file_name, 'w') do |f|
        f.write(text)
      end
    end

  end

end
