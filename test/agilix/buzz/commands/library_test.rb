require "test_helper"

class Agilix::Buzz::Commands::LibraryTest < Minitest::Test

  describe "#get_library_page" do
    it "get_library_page" do
      VCR.use_cassette("Commands::Library get_library_page for domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        page_id = 'd9ae5401ddad42d7805f3e2486fc8655'
        response = api.get_library_page domainid: TEST_SUBDOMAIN_ID, pageid: page_id
        page = response.dig 'response', 'page'
        assert page
        assert_equal page_id, page['id']
      end
    end
  end

  describe "#list_library_pages" do
    it "list_library_pages" do
      VCR.use_cassette("Commands::Library list_library_pages for domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.list_library_pages domainid: TEST_SUBDOMAIN_ID
        assert response.success?
        pages = response.dig('response', 'pages', 'page')
        assert_kind_of Array, pages
        assert_equal TEST_SUBDOMAIN_ID, pages.sample["domainid"]
      end
    end
  end

  describe "#create_library_page" do
    it "create_library_page" do
      VCR.use_cassette("Commands::Library create_library_page for domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.create_library_page domainid: TEST_SUBDOMAIN_ID, libraryid: 'testlib', title: "Greatest ever", description: "This really is the best", body: "<h1>Check it out!</h1><iframe src='https://www.google.com'></iframe>"
        assert response.success?
        page_id = response.dig('response', 'page', 'pageid')
        assert page_id
      end
    end
  end

# search_library_pages

end
