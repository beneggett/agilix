module Agilix
  module Buzz
    module Commands
      module Authentication

        # This is handled automatically by instantiation of a base Agilix::Buzz::Api instance. It wouldn't need to be called manually unless using for other users or making calls on their behalf
        #  api.login username: 'my-username', password: 'my-password', domain: 'my-domain'
        def login2(username: , password: , domain: )
          post cmd: "login2", username: "#{domain}/#{username}", password: password
        end
        alias_method :login, :login2

        # api.logout
        def logout
          response = authenticated_get cmd: "logout"
          @token = nil
          @token_expiration = nil
          response
        end

        # This is handled automatically by instantiation of a base Agilix::Buzz::Api instance and on subsequent calls to the api through the check_authentication method
        # api.extend_session
        def extend_session
          response = authenticated_post cmd: "extendsession", bypass_authentication_check: true
          @token_expiration = set_token_expiration(response.dig("response", "session", "authenticationexpirationminutes"))
          authenticate! if response['code'] == 'NoAuthentication'
          response
        end

        def set_token_expiration(minutes)
          Time.now + (minutes.to_i * 60 )
        end

        # api.force_password_change userid: 57181
        def force_password_change(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options )
          authenticated_post cmd: "forcepasswordchange", **options
        end

        # api.get_password_login_attempt_history userid: 57181
        # api.get_password_login_attempt_history userid: 57181, earliestrecordtoreturn: '2018-01-01'
        def get_password_login_attempt_history(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( earliestrecordtoreturn ), options: options )
          authenticated_get cmd: "getpasswordloginattempthistory", **options
        end

        # api.get_password_policy
        # api.get_password_policy domainid: 57031
        def get_password_policy(options = {})
          options = argument_cleaner(required_params: %i(  ), optional_params: %i( domainid bypasscache ), options: options )
          authenticated_get cmd: "getpasswordpolicy", **options
        end

        # api.get_password_question username: "auto-tests/BuzzUserUp1"
        def get_password_question(options = {})
          options = argument_cleaner(required_params: %i( username ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getpasswordquestion", **options
        end

        # ISSUE: This works with a GET call
        # api.update_password_question_answer userid: 57181, passwordquestion: "Where is your favorite vacation place?", passwordanswer: "Hawaii"
        def update_password_question_answer(options = {})
          options = argument_cleaner(required_params: %i( userid passwordquestion passwordanswer ), optional_params: %i( oldpassword ), options: options )
          authenticated_post cmd: "updatepasswordquestionanswer", **options
        end

        # api.proxy userid: 57181
        def proxy(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( noazt ), options: options )
          options[:noazt] ||= true
          authenticated_post cmd: "proxy", **options
        end

        # proxy_api = api.proxy_api userid: 57181
        # proxy_api.unproxy userid: 57181
        def unproxy(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( noazt ), options: options )
          authenticated_post cmd: "unproxy", **options
        end


        # proxy_api = api.proxy_api userid: 57181
        def proxy_api(userid: )
          response = proxy userid: userid
          self.class.new username: response.dig('response', 'user', 'username'), token: response.dig('response', 'user', 'token'), domain: response.dig('response', 'user', 'userspace'), token_expiration: set_token_expiration(response.dig('response', 'user', 'authenticationexpirationminutes'))
        end


        # :skip_test_coverage:
        # api.proxy_sso_link userid: 57181
        def proxy_sso_link(userid: )
          response = proxy userid: userid
          sso =  {
             "customization": {
                "authentication": {
                   "provider": {
                      "server": "https://www.google.com"
                   }
                }
             }
          }
          self.update_domains [ {domainid: response.dig('response', 'user', 'domainid'), data: sso}]
          # userspace = response.dig('response', 'user', 'userspace')
          "https://api.leaderinme.net/SSOLogin?domainid=#{response.dig('response', 'user', 'domainid')}&url=/home&token=#{response.dig('response', 'user', 'token')}"
        end
        # :skip_test_coverage:

        # api.reset_lockout userid: 57181
        def reset_lockout(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( ), options: options )
          authenticated_post cmd: "resetlockout", **options
        end

        # api.reset_password username:'auto-tests/BuzzUserUp1'
        def reset_password(options = {})
          options = argument_cleaner(required_params: %i( username ), optional_params: %i( answer ), options: options )
          authenticated_get cmd: "resetpassword", **options
        end

       # api.update_password userid: 57181, password: "IChanged123"
        def update_password(options = {})
          options = argument_cleaner(required_params: %i( userid password ), optional_params: %i( token oldpassword ), options: options )
          authenticated_get cmd: "updatepassword", **options
        end

        # ISSUE: This should be a POST method as it's storing data
        # api.put_key entityid: 57031, name: 'secret_key_1', value: "Super Secret"
        def put_key(options = {})
          options = argument_cleaner(required_params: %i( entityid name value ), optional_params: %i( ), options: options )
          authenticated_get cmd: "putkey", **options
        end

        # api.get_key entityid: 57031, name: 'secret_key_1',
        def get_key(options = {})
          options = argument_cleaner(required_params: %i( entityid name ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getkey", **options
        end

        # This requires a key to exist with the given keyname, see putkey
        # not sure what its used for yet
        # api.compute_hmac
        def compute_hmac(options = {})
          options = argument_cleaner(required_params: %i( domainid keyname message ), optional_params: %i( algorithm format ), options: options )
          options[:message] = "$VAR_USERID#{options[:message]}$VAR_SECRETTime$VAR_TIME"
          authenticated_get cmd: "computeHMAC", **options
        end

      end
    end
  end
end
