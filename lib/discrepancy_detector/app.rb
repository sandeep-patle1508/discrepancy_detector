require './lib/discrepancy_detector/print_helper'

module DiscrepancyDetector
  class App
    include PrintHelper

    # support action and corresponding detector service
    SUPPORTED_DISCREPANCY_DETECTOR = {
      'campaign' => DiscrepancyDetector::CampaignDiscrepancyDetector
    }.freeze

    # instance method to call the discrepancy detector as per given action type
    # @params command line ARGV - action type
    #
    # @return print output on screen
    def run(argv)
      if argv.size == 1 && !argv.first.empty? && SUPPORTED_DISCREPANCY_DETECTOR.keys.include?(argv.first)
        discrepancies = SUPPORTED_DISCREPANCY_DETECTOR[argv.first].call
        print_discrepancy_result(discrepancies)
      else
        abort 'We do not support this action, please enter a valid action.'
      end
    end
  end
end