INTRODUCTION

    Benchtool provides a method to store a list of 'targets', which you can then 
    benchmark using the Apache Bench web server benchmarking tool.

    This tool expects a configuration file at config/configuration.yml. If not
    found, one will be created for you. This tool also outputs Apache Bench data
    to a gnuplot file in a directory named 'output'. If it is not present, it will
    be created. Both of these can be overriden using options.

PREREQUISITES

    Because benchtool is a simple wrapper script, you must install Apache Bench 
    and Curl prior to running this utility. You can check to see if you have 
    these tools installed by executing the following at a shell prompt:

        which ab
        which curl

    These commands should return paths to the binaries for each. If nothing is 
    returned, you must install the utility using your preferred package manager.

BASIC USAGE
    
    benchtool [options] <command>

    options - optional switches passed to the utility (see OPTIONS)

    command - required command parameter tells the utility what action to take

    See EXAMPLES for more details.

COMMANDS

    benchmark     Execute Apache Benchmark against a target. Builds and executes an 
                  Apache Bench command, specifying cookies and headers from the 
                  configuration file.
    test          Test a target to determine if it is valid and responding. Builds
                  and executes a Curl command, specifying cookies and headers from 
                  the configuration file.

OPTIONS

    -c, --concurrency [INT]          Apache Bench concurrency level (overrides config).
    -o, --output-dir [PATH]          Output directory for Apache Bench gnuplot files.
    -n, --number [INT]               Apache Bench number of requests (overrides config).
        --no-plotfile                Apache Bench will not write a gnuplot file.
    -p, --print                      Print the command and exit; does not execute.
    -t, --target [INT]               Specify the index (1-based) of the target.

EXAMPLES

    benchtool benchmark         - Displays a menu list of targets and executes 
                                  Apache Bench against the selected target.

    benchtool test              - Displays a menu list of targets and executes 
                                  a brief test showing the first 30 lines of 
                                  the HTTP response.

    benchtool -c 100 benchmark  - Override the configuration.yml concurrency 
                                  setting for Apache Bench.

    benchtool -p benchmark      - Prints the resulting bash shell command, rather 
                                  than executing. Also works for the test command.

Author: Brad Landers <brad@bradlanders.com>
Source: http://github.com/bradland/benchtool/
