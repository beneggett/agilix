require "test_helper"

class Agilix::Buzz::Commands::CourseTest < Minitest::Test

  describe '#copy_courses' do
    it "Returns a list of courses by id " do
      VCR.use_cassette("Commands::Course copy_courses course 60982 to domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.copy_courses domainid: TEST_SUBDOMAIN_ID, courseid: 60982
        assert response.success?
        r = response.dig('response', 'responses', 'response').first
        assert_equal "OK", r['code']
        assert r['course'].present?
      end
    end
  end

  describe '#list_courses' do
    it "Returns a list of courses by id " do
      VCR.use_cassette("Commands::Course list_courses for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.list_courses domainid: TEST_DOMAIN_ID,  show: 'all'
        assert response.success?
        assert response.dig('response', 'courses', 'course').present?
        assert response.dig('response', 'courses', 'course').sample["title"]
      end
    end

    it "Returns a list of all courses" do
      VCR.use_cassette("Commands::Course list_courses all", match_requests_on: [:query]) do
        response = api.list_courses domainid: '0'
        assert response.success?
        assert response.dig('response', 'courses', 'course').present?
      end
    end
  end


end
