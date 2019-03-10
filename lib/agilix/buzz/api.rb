module Agilix
  module Buzz
    class Api
      URL_ENDPOINT = ENV.fetch("AGILIX_BUZZ_URL", "https://api.schooldigger.com")
      URL_BASE = "#{URL_ENDPOINT}/cmd"
      include HTTParty

      include Agilix::Buzz::Commands::Authentication
      include Agilix::Buzz::Commands::Course
      include Agilix::Buzz::Commands::Domain
      include Agilix::Buzz::Commands::General

      attr_accessor :username, :password, :domain, :token, :token_expiration

      def initialize(options = {})
        @username = options.fetch(:username, default_username)
        @password = options.fetch(:password, default_password)
        @domain = options.fetch(:domain, default_domain)
      end

      def authenticated_get(query = {})
        check_authentication
        get query
      end

      def authenticated_post(query = {})
        check_authentication
        post query
      end

      def authenticated_bulk_post(query = {})
        check_authentication
        bulk_post query
      end

      def get(query = {})
        response = self.class.get(URL_BASE, query: modify_query(query), timeout: 30, headers: headers)
      end

      def post(query = {})
        response = self.class.post(URL_BASE, body: modify_body(query), timeout: 30, headers: headers)
      end

      def bulk_post(query = {})
        cmd = query.delete(:cmd)
        url = URL_BASE + "?cmd=#{cmd}&_token=#{token}"
        response = self.class.post(url, body: modify_bulk_body(query), timeout: 30, headers: headers)
      end

      def check_authentication
        if token && token_expiration
          if token_expiration < Time.now
            extend_session
          end
        else
          response = login username: @username, password: @password, domain: @domain
          @token = response.dig("response", "user", "token")
          @token_expiration = Time.now + (response.dig("response", "user", "authenticationexpirationminutes").to_i * 60 )
        end
      end

      def argument_cleaner(required_params: , optional_params: , options: )
        missing_required = required_params - options.map {|k,v| k.to_sym }
        raise ArgumentError.new("Missing Required Arguments: #{missing_required.join(', ')}") if missing_required.any?

        all_params = (required_params + optional_params).flatten
        return options.select {|k,v| all_params.include?(k.to_sym)}
      end

      private

      def modify_query(query = {})
        default_params = {}
        default_params.merge! query
        default_params["_token"] =  token if token
        default_params
      end

      def modify_body(body = {})
        default_params = { request: {}.merge(body) }
        default_params[:request]["_token"] = token if token
        default_params.to_json
      end

      def modify_bulk_body(query = {})
        root_node = query.delete(:root_node)
        default_params = { requests: { root_node.to_sym => query[:body] } }
        default_params.to_json
      end

      def headers
        {
          "Accept" => "application/json",
          "Content-Type" => "application/json",
        }
      end

      def default_username
        ENV["AGILIX_BUZZ_USERNAME"]
      end

      def default_password
        ENV["AGILIX_BUZZ_PASSWORD"]
      end

      def default_domain
        ENV["AGILIX_BUZZ_DEFAULT_DOMAIN"]
      end

    end
  end
end
