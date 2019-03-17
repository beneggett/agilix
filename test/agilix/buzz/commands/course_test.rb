require "test_helper"

class Agilix::Buzz::Commands::CourseTest < Minitest::Test

  describe '#copy_courses' do
    it "Copies a course to a domain" do
      VCR.use_cassette("Commands::Course copy_courses course 60982 to domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.copy_courses [{domainid: TEST_SUBDOMAIN_ID, courseid: 60982 }]
        assert response.success?
        course_response = response.dig('response', 'responses', 'response').first
        assert_equal "OK", course_response['code']
        assert course_response['course'].present?
      end
    end
  end

  describe '#create_courses' do
    it "Creates courses" do
      VCR.use_cassette("Commands::Course create_courses new course for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.create_courses [{domainid: TEST_DOMAIN_ID, title: "Test Course", status: 1, type: "Continuous"}]
        assert response.success?
        course_response = response.dig('response', 'responses', 'response').first
        assert_equal "OK", course_response['code']
        assert course_response['course'].present?
      end
    end
  end

  describe '#create_demo_course' do
    it "Creates demo course" do
      VCR.use_cassette("Commands::Course create_demo_course for domain #{TEST_DOMAIN_ID} from course 60982", match_requests_on: [:query]) do
        response = api.create_demo_course courseid: 60982, domainid: 57025, title: "Demo Course", daysoffset: 60
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        assert response.dig('response', 'course', 'courseid').present?
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
