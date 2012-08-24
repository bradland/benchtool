module BenchTool
  class ABCmdBuilder

    def initialize(params, options = {})
      @params = params
      @options = options
      # Sample ab cmd
      # ab -n #{requests} -c #{concurrency} -g '#{plotfile}' -C '#{cookies}' -H '#{header}' '#{url}'
      @parts = {
        :base => "ab ", 
        :requests => "-n %s ", 
        :concurrency => "-c %s ", 
        :plotfile => "-g '%s' ", 
        :cookies => "-C '%s' ", 
        :header => "-H '%s' ", 
        :url => "'%s'", 
      }
    end

    def to_str
      cmd = ""
      cmd << @parts[:base]
      cmd << @parts[:requests]     % @params[:requests]
      cmd << @parts[:concurrency]  % @params[:concurrency]
      cmd << @parts[:plotfile]     % @params[:plotfile]     unless @options[:no_plotfile] == false
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
