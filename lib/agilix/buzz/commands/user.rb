module Agilix
  module Buzz
    module Commands
      module User

        # api.create_users [{ domainid: '57025', username: "BuzzUserTest1", email: 'buzzusertest1@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Man", passwordquestion: "Who's your best friend?", passwordanswer: "Me"}]
        def create_users2(items = [])
          options = items.map do |item|
            options = argument_cleaner(required_params: %i( domainid username email password firstname lastname   ), optional_params: %i( passwordquestion passwordanswer reference flags rights roleid data ), options: item )
          end
          authenticated_bulk_post cmd: "createusers2", root_node: 'user', body: options
        end
        alias_method :create_users, :create_users2

        # api.delete_users [userid: '57181']
        def delete_users(items = {})
          options = items.map do |item|
            options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: item )
          end
          authenticated_bulk_post cmd: "deleteusers", root_node: 'user', body: options
        end

        # api.get_active_user_count domainid: '57025'
        # api.get_active_user_count domainid: '5', includedescendantdomains: true, bymonth:true, startdate: '2018-01-01', enddate: '2019-03-01'
        def get_active_user_count(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i(includedescendantdomains persona startdate enddate byday bymonth byyear ), options: options)
          authenticated_get cmd: "getactiveusercount", **options
        end

        # api.get_domain_activity domainid: '57025'
        def get_domain_activity(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( startdate enddate maxusers select ), options: options)
          authenticated_get cmd: "getdomainactivity", **options
        end

        # api.get_profile_picture
        def get_profile_picture(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "getprofilepicture", **options
        end

        # api.getuser2
        def get_user2(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "getuser2", **options
        end
        alias_method :get_user, :get_user2

        # api.getuseractivity
        def getuseractivity(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "getuseractivity", **options
        end

        # api.getuseractivitystream
        def getuseractivitystream(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "getuseractivitystream", **options
        end

        # api.listusers
        def listusers(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "listusers", **options
        end

        # api.restoreuser
        def restoreuser(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "restoreuser", **options
        end

        # api.updateusers
        def updateusers(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options)
          authenticated_get cmd: "updateusers", **options
        end

      end
    end
  end
end
