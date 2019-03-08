module Agilix
  module Buzz
    module Commands
      module Authentication


        def login_2(username: , password: , domain: )
          post cmd: "login2", username: "#{domain}/#{username}", password: password
        end
        alias_method :login, :login_2

        def extend_session
          response = authenticated_post cmd: "extendsession"
          @token_expiration = Time.now + (response.dig("response", "session", "authenticationexpirationminutes").to_i * 60 )
          response
        end

      end
    end
  end
end
