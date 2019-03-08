module Agilix
  module Buzz
    module Commands
      module Course

        # api = Agilix::Buzz::Api::new
        # api.list_courses
        # api.list_courses domainid: 5
        def list_courses(options = {})
          authenticated_get cmd: "listcourses", domainid: options.fetch(:domainid, 0)
        end


      end
    end
  end
end
