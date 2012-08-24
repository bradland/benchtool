module BenchTool
  class Benchmarker

    def initialize(options = {})
      @appconfig = AppConfig.load
      @config = @appconfig[:configuration]
      @targets = @appconfig[:targets]
      @options = options
      # Overwrite app config with options (usually passed as CLI options)
      unless options.nil?
        @config.merge!(options)
      end
    end

    def benchmark
      setup_output
      benchmark_target(select_target)
    end

    def test
      target = select_target
      test_target(target)
    end

    private

    def benchmark_target(target)
      # Set up the params we'll send to the Apache Bench cmd builder
      ab_params = {
        :requests    => @config[:ab_requests],
        :concurrency => @config[:ab_concurrency],
        :plotfile    => File.expand_path(File.join(@config[:ab_output], "apache-#{Time.now.strftime('%Y%m%d-%H%M%S')}.tsv")),
        :cookies     => target[:cookies],
        :headers     => target[:headers],
        :url         => target[:url]
      }

      # Output to inform the user what is about to happen
      console ""
      console "Benchmarking:"
      console "  URL:         #{ab_params[:url]}"
      console "  Concurrency: #{ab_params[:concurrency]}"
      console "  Requests:    #{ab_params[:requests]}"
      console ""

      # Build the command and execute or print
      cmd = ABCmdBuilder.new(ab_params, @options).to_str
      if @options[:print_no_exec]
        console "Print cmd requested; no exec:"
        console ""
        console 
      else
        console "Apache Bench output follows [#{Time.now.strftime('%F %T')}]================================"
        run_shell_cmd cmd
      end
    end

    def test_target(target)
      # Set up the params we'll send to the curl cmd builder
      curl_params = {
        :cookies => target[:cookies],
        :headers => target[:headers],
        :url     => target[:url]
      }

      # Output to inform the user what is about to happen
      console ""
      console "Testing:"
      console "  URL:         #{curl_params[:url]}"
      console ""

      # Build the command and execute or print
      cmd = CurlCmdBuilder.new(curl_params, @options).to_str
      if @options[:print_no_exec]
        console "Print cmd requested; no exec:"
        console ""
        console cmd
      else
        console "Curl output follows [#{Time.now.strftime('%F %T')}]================================"
        result = `#{cmd}`
        puts result.split("\n").first(30)
      end
    end

    def select_target
      # Return a target immediately if specified as an option
      if @options.key?(:target_idx)
        return @targets[@options[:target_idx]]
      end
      # Otherwise present a menu and return the choice
      begin
        selection = choose do |menu|
          menu.prompt = "Select a target:"
          @targets.each_with_index do |target, i|
            menu.choice target[:name] { i }
          end
        end
      rescue Interrupt
        console ""
        console "SIGINT received, Goodbye!"
        exit 1
      end
      @targets[selection]
    end

    def setup_output
      output_dir = File.expand_path(@config[:ab_output])
      unless Dir.exists?(output_dir)
        console "Creating output directory because it didn't exist."
        FileUtils.mkdir_p(output_dir)
      end
      console "Using output dir: #{output_dir}"
    end

  end # class Benchmarker
end # module BenchTool
