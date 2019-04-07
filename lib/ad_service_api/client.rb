require 'httparty'

# Using test campaigns API
module AdServiceApi
  class Client
    include HTTParty

    # base URI of campaigns api
    base_uri 'https://mockbin.org/bin'.freeze

    # get list of campaigns
    #
    # @return HTTParty response
    def get_campaigns
      get('/fcb30500-7b98-476f-810d-463a0b8fc3df')
    end

    private

    def get(request_url)
      self.class.get(request_url)
    end
  end
end