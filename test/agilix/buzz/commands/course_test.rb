require "test_helper"

class Agilix::Buzz::Commands::CourseTest < Minitest::Test
  SOURCE_COURSE_ID     = 60982
  DEACTIVATE_COURSE_ID = 60990
  DELETE_COURSE_ID     = 60994

  describe '#copy_courses' do
    it "Copies a course to a domain" do
      VCR.use_cassette("Commands::Course copy_courses course #{SOURCE_COURSE_ID} to domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.copy_courses [{domainid: TEST_SUBDOMAIN_ID, courseid: SOURCE_COURSE_ID }]
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
      VCR.use_cassette("Commands::Course create_demo_course for domain #{TEST_DOMAIN_ID} from course #{SOURCE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.create_demo_course courseid: SOURCE_COURSE_ID, domainid: 57025, title: "Demo Course", daysoffset: 60
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
        assert response.dig('response', 'course', 'courseid').present?
      end
    end
  end

  describe '#deactivate_course' do
    it "Deactivates a courses by id " do
      VCR.use_cassette("Commands::Course deactivate_course for course #{DEACTIVATE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.deactivate_course courseid: DEACTIVATE_COURSE_ID
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
      end
    end
  end

  describe '#delete_courses' do
    it "deletes courses" do
      VCR.use_cassette("Commands::Course delete_courses for course #{DELETE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.delete_courses [{courseid: DELETE_COURSE_ID}]
        assert response.success?
        course_response = response.dig('response', 'responses', 'response').first
        assert_equal "OK", course_response['code']
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

  describe '#restore_course' do
    it "restores a course" do
      VCR.use_cassette("Commands::Course restore_course for course #{DELETE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.restore_course courseid: DELETE_COURSE_ID
        assert response.success?
        assert_equal "OK", response.dig('response', 'code')
      end
    end
  end



end
