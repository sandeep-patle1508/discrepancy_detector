require 'active_support/concern'

module DiscrepancyDetector
  module Callable
    extend ActiveSupport::Concern
    
    class_methods do
      def call(*args)
        new(*args).call
      end
    end
  end
end