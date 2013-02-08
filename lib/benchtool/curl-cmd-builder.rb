module BenchTool
  class CurlCmdBuilder

    def initialize(params, options = {})
      @params = params
      @options = options
      # Sample curl status cmd
      # Flag --insecure allows use of self-signed certs
      # curl -siL --insecure --cookies '#{cookies}' --header '#{header}' "#{url}"
      @parts = {
        :base => "curl -siL ", 
        :insecure => "--insecure ", 
        :cookies => "--cookie '%s' ", 
        :header => "--header '%s' ", 
        :url => "'%s'", 
      }
    end

    def to_str
      cmd = ""
      cmd << @parts[:base]
      cmd << @parts[:cookies]      % @params[:cookies]
      unless @params[:headers].empty?
        @params[:headers].each do |header|
          cmd << @parts[:header]   % header
        end
      end
      cmd << @parts[:url]          % @params[:url]
    end

  end # class ABCmdBuilder
end # module BenchTool
