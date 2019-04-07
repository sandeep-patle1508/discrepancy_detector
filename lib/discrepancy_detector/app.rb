module DiscrepancyDetector
  class App

    # support action and corresponding detector service
    SUPPORTED_DISCREPANCY_DETECTOR = {
      'campaign' => DiscrepancyDetector::CampaignDiscrepancyDetector
    }.freeze

    def run(argv)
      if argv.size == 1 && !argv.first.empty? && SUPPORTED_DISCREPANCY_DETECTOR.keys.include?(argv.first)

      else
        abort 'We do not support this action, please enter a valid action.'
      end
    end
  end
end