require 'active_support/core_ext/object'
require 'nokogiri'
require 'colorize'
require 'yaml'

require_relative 'spring_to_csharp/version'
require_relative 'spring_to_csharp/config'
require_relative 'spring_to_csharp/cli'
require_relative 'spring_to_csharp/converter/spring_keys'
require_relative 'spring_to_csharp/converter/tag_names'
require_relative 'spring_to_csharp/converter/templates'
require_relative 'spring_to_csharp/converter'

module SpringToCSharp

  def self.run
    Cli.new
    true
  end


end
