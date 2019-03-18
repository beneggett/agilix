module Agilix
  module Buzz
    module Commands
      module General

        # api.echo test: 'param'
        def echo(options= {})
          post cmd: "echo", **options
        end

        # api.get_command_list
        def get_command_list
          get cmd: "getcommandlist"
        end

        # ISSUE: nothing saying this is an authenticated call, when others are non-authenticated
        # api.get_entity_type entityid: 57025
        def get_entity_type(options = {})
          options = argument_cleaner(required_params: %i( entityid ), optional_params: %i( select ), options: options )
          authenticated_get cmd: "getentitytype", **options
        end

        # ISSUE: docs in getting started reference a `level` param, actual docs suggest using rating
        # api.get_status rating: 4, html: true, sms: true
        def get_status(options = {})
          options = argument_cleaner(required_params: %i(  ), optional_params: %i( rating sms html ), options: options )
          authenticated_get cmd: "getstatus", **options
        end

        # this is a non-authenticated call
        # api.get_status
        def get_basic_status(options = {})
          options = argument_cleaner(required_params: %i(  ), optional_params: %i( rating sms html ), options: options )
          get cmd: "getstatus", **options
        end

        # ISSUE: Docs have cmd spelled wrong, this API doesn't seem to work at all AccessDenied. It did say experimental
        # api.get_upload_limits
        # api.get_upload_limits domainid: 57025
        def get_upload_limits(options = {})
          options = argument_cleaner(required_params: %i(  ), optional_params: %i( userid domainid ), options: options )
          get cmd: "getuploadlimits", **options
        end

        def send_mail(options = {})
          options = argument_cleaner(required_params: %i( subject body enrollmentid enrollment_ids ), optional_params: %i( groups roles strings), options: options )
          request = {email: {
            subject: {"$value" => options[:subject]},
            body: {"$value" => options[:body]},
            enrollments: {enrollment: options[:enrollment_ids].map {|id| {id: id} } }
          }}
          request[:email][:groups] = {group: options[:groups].map {|id| {id: id} } } if options[:groups]
          request[:email][:roles] = {role: options[:roles].map {|id| {id: id} } } if options[:roles]
          if options[:strings]
            request[:email][:strings] = options[:strings].map do |k,v|
              [ k , {"$value" => v } ]
            end.to_h
          end
          enrollment_response = self.get_enrollment enrollmentid: options[:enrollmentid]
          user_id = enrollment_response.dig("response", "enrollment", "userid")
          proxy_api = self.proxy_api userid: user_id
          proxy_api.authenticated_query_post query_params: {cmd: "sendmail", enrollmentid: options[:enrollmentid] },  **request
        end


      end
    end
  end
end
