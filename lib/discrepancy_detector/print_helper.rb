require 'json'

module DiscrepancyDetector
  module PrintHelper
    # display result on screen
    def print_discrepancy_result(discrepancies)
      print_line('Discrepancy Result:')

      unless discrepancies.empty?
        discrepancies.each do |key, value|
          print_line("#{key.to_s.gsub('_', ' ')}")
          print_line(JSON.pretty_generate(value))
          print_line("\n")
        end
      else
        print_line('No discrepancies found')
      end
    end

    # print a line
    def print_line(line)
      puts line
    end

    # print exception error in well format
    def self.print_error(e)
      puts("Script failed with error - #{e}")
      puts(e.backtrace.join("\n"))
    end
  end
end
