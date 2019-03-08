module Agilix
  module Buzz
    class Api
      URL_ENDPOINT = ENV.fetch("AGILIX_BUZZ_BASE_URL", "https://api.schooldigger.com")
      API_VERSION = ENV.fetch("AGILIX_BUZZ_API_VERSION", "1.1")
      URL_BASE = "#{URL_ENDPOINT}/v#{API_VERSION}"
      include HTTParty

      def get(path, query = {})
        response = self.class.get(URL_BASE + path, query: modify_query(query), timeout: 30)
      end

      # # Agilix::Buzz::Api.new.autocomplete('San Die', st: "CA")
      def autocomplete(query, options = {} )
        available_options = %w(q st level boxLatitudeNW boxLongitudeNW boxLatitudeSE boxLongitudeSE returnCount)
        options = options.select {|k,v| available_options.include?(k.to_s)}
        options[:q] = query
        get "/autocomplete/schools", options
      end

      # # Agilix::Buzz::Api.new.districts('CA')
      def districts(state, options = {} )
        available_options = %w(st q city zip nearLatitude nearLongitude boundaryAddress distanceMiles isInBoundaryOnly boxLatitudeNW boxLongitudeNW boxLatitudeSE boxLongitudeSE page perPage sortBy)
        options = options.select {|k,v| available_options.include?(k.to_s)}
        options[:st] = state
        options[:perPage] ||= 50
        options[:page] ||= 1
        get "/districts", options
      end

      # # Agilix::Buzz::Api.new.district("0600001")
      def district(district_id)
        response = get "/districts/#{district_id}"
        return "Not Found" if response.code == 404
        response
      end

      # # Agilix::Buzz::Api.new.district_rankings('CA')
      def district_rankings(state, options = {} )
        available_options = %w(st year page perPage)
        options = options.select {|k,v| available_options.include?(k.to_s)}
        options[:perPage] ||= 50
        options[:page] ||= 1
        get "/rankings/districts/#{state}", options
      end


      # # Agilix::Buzz::Api.new.schools('CA')
      # # Agilix::Buzz::Api.new.schools('CA', q: "East High")
      def schools(state, options = {} )
        available_options = %w(st q districtID level city zip isMagnet isCharter isVirtual isTitleI isTitleISchoolwide nearLatitude nearLongitude boundaryAddress distanceMiles isInBoundaryOnly boxLatitudeNW boxLongitudeNW boxLatitudeSE boxLongitudeSE page perPage sortBy)
        options = options.select {|k,v| available_options.include?(k.to_s)}
        options[:st] = state
        options[:perPage] ||= 50
        options[:page] ||= 1
        get "/schools", options
      end

      # # Agilix::Buzz::Api.new.school("490003601072")
      def school(school_id)
        response = get "/schools/#{school_id}"
        return "Not Found" if response.code == 404
        response
      end

      # # Agilix::Buzz::Api.new.school_rankings('CA')
      def school_rankings(state, options = {} )
        available_options = %w(st year level page perPage)
        options = options.select {|k,v| available_options.include?(k.to_s)}
        options[:perPage] ||= 50
        options[:page] ||= 1
        get "/rankings/schools/#{state}", options
      end

      ## response = Agilix::Buzz::Api.new.districts('CA')
      ## next_page_response = Agilix::Buzz::Api.new.next_page(response)
      def next_page(response)
        max_pages = response["numberOfPages"]
        original_query  = response.request.options[:query]
        current_page = original_query[:page]
        next_page = current_page.to_i + 1
        raise "Already at Last Page" if current_page >= max_pages

        query = original_query.merge({page: next_page})
        Agilix::Buzz::Api.get( response.request.path, query: query, timeout: 30)
      end

      private

      def modify_query(query)
        default_params = {
          appID: ENV.fetch("AGILIX_BUZZ_USERNAME", 'not-implemented'),
          appKey:  ENV.fetch("AGILIX_BUZZ_PASSWORD", 'not-implemented')
        }
        default_params.merge query
      end
    end
  end
end
