module BenchTool
  # A structureless datastore; loads and persists to a YML file in a configured location
  module AppConfig

    CONFIG_DIR = File.expand_path('./config')
    CONFIG_FILE = 'configuration.yml'
    CONFIG_PATH = File.join(CONFIG_DIR, CONFIG_FILE)

    @@options = {}
    
    # Load config
    def self.load
      @@options = fetch
    end

    # Safe method to reload new settings
    def self.reload
      options = fetch rescue nil
      @@options = options || {}
    end
    
    # Get configuration option
    def self.[](key)
      @@options[key.to_s]
    end
    
    # Get configuration option by attribute
    def self.method_missing(method, *args)
      @@options[method.to_s]
    end
    
    # Returns true if configuration key exists
    def self.exist?(key)
      @@options.key?(key)
    end
    
    protected
    
    # Get options from configuration file
    def self.fetch
      if File.exists?(File.join(CONFIG_DIR, CONFIG_FILE))
        @@options = YAML::load(File.open(CONFIG_PATH))
      else
        @@options = {}
      end
      @@options.deep_symbolize
    end

  end # module AppConfig
end # module BenchTool