module Agilix
  module Buzz
    module Commands
      module General

        # api = Agilix::Buzz::Api::new
        # api.get_status
        def get_status
          get cmd: "getstatus", level: 2
        end

      end
    end
  end
end
