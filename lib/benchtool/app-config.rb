module BenchTool
  class AppConfig

    CONFIG_DIR = File.expand_path('./config')
    CONFIG_FILE = 'configuration.yml'
    CONFIG_PATH = File.join(CONFIG_DIR, CONFIG_FILE)
    APP_CONFIG_DIR = File.expand_path(File.dirname(__FILE__))

    def initialize
      @options ||= fetch
    end

    # Return config as hash
    def to_hash
      @options
    end

    private
    
    # Get options from configuration file
    def fetch
      setup unless config_exists?
      console "Loading config from #{CONFIG_PATH}"
      @options = YAML::load(File.open(CONFIG_PATH))
      @options.deep_symbolize
    end

    def config_exists?
      File.exists?(CONFIG_PATH)
    end

    def setup
      FileUtils.mkdir_p(CONFIG_DIR)
      FileUtils.cp(File.join(APP_CONFIG_DIR, 'configuration.yml.base'), CONFIG_PATH)
      console "Default configuration was established in the cwd!"
      console ""
      console "NOTICE: The application will exit now. Edit the contents of the config file before proceeeding!"
      console ""
      console "Config file path:"
      console "  #{CONFIG_PATH}"
      exit 0
    end

  end # module AppConfig
end # module BenchTool
