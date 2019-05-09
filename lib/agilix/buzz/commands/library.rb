module Agilix
  module Buzz
    module Commands
      module Library

        # api.get_library_page domainid: 57031, pageid: "230433194a1e4699bfa576aa6e6743c6"
        def get_library_page(options = {})
          options = argument_cleaner(required_params: %i( domainid pageid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getlibrarypage", **options
        end

        # api.list_library_pages domainid: 57031
        def list_library_pages(options = {})
          options = argument_cleaner(required_params: %i(  domainid ), optional_params: %i( libraryid limit select ), options: options )
          authenticated_get cmd: "listlibrarypages", **options
        end

        # api.create_library_page domainid: 57031, libraryid: 'testlib', title: "Greatest ever", description: "This really is the best", body: "<h1>Check it out!</h1><iframe src='https://www.google.com'></iframe>"
        def create_library_page(options = {})
          optional_params = argument_cleaner(required_params: %i( domainid libraryid title description  ), optional_params: %i( body id name 'meta-featured' 'meta-type' 'meta-category' ), options: options )
          # authenticated_query_post cmd: "putresource", **options
          authenticated_post cmd: "createlibrarypage", **options
        end

        # # api.search_library_pages domainid: 57031, path: "banner.css"
        # def search_library_pages(options = {})
        #   options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( libraryid limit select q ), options: options )
        #   authenticated_get cmd: "searchlibrarypages", **options
        # end

      end
    end
  end
end

# createlibrarypagebookmark
# deletelibrarypage
# deletelibrarypagebookmark
# listlibrarypagebookmarks
# populatelibrarypageedits
# populatelibrarypageedits
# reindexlibrarypages
# updatelibrarypage