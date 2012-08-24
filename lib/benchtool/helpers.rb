# Writes msg to STDERR (helps with bash shell redirection)
def console(msg)
  STDERR.puts msg
end

# Open4 version (doesn't write output in real time)
# def run_shell_cmd(cmd)
#   status = Open4::popen4('sh') do |pid, stdin, stdout, stderr|
#     # puts "debug: #{cmd}"  if @options[:debug]
#     stdin.puts cmd
#     stdin.close
#     puts stdout.read
#   end
#   status
# end

# PTY version (writes to output in real time)
def run_shell_cmd(cmd)
  begin
    PTY.spawn(cmd) do |r, w, pid|
      begin
        r.each { |line| print line;}
      rescue Errno::EIO
      rescue Interrupt
        console ""
        console "Goodbye!"
      end
    end
  rescue PTY::ChildExited => e
    puts "The child process exited!"
  end
end
