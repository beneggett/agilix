require "test_helper"

class Agilix::Buzz::Commands::EnrollmentTest < Minitest::Test


  describe "#enrollment_status" do
    it "has a hash map" do
      assert_kind_of Hash, api.enrollment_status
      assert_equal 1, api.enrollment_status[:active]
      assert_equal 8, api.enrollment_status.keys.count
    end
  end

  describe "#enrollment_status_lookup_value" do
    it "returns a status by value" do
      assert_equal :active, api.enrollment_status_lookup_value(1)
      assert_equal :completed, api.enrollment_status_lookup_value(7)
    end

    it "returns an error if bad value" do
      assert_raises ArgumentError do
        api.enrollment_status_lookup_value(100)
      end
    end
  end

  describe "#create_enrollments" do
    it "creates a new enrollment" do
      VCR.use_cassette("Commands::Enrollment create_enrollments for user #{TEST_USER_ID} for course #{TEST_SOURCE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.create_enrollments [{userid: TEST_USER_ID, entityid: TEST_SOURCE_COURSE_ID}]
        assert response.success?
        enrollment_id = response.dig("response", "responses", "response").first.dig("enrollment", "enrollmentid")
        assert enrollment_id
      end
    end

    it "creates an enrollment but doesn't allow duplicates using flag" do
      VCR.use_cassette("Commands::Enrollment create_enrollments without duplicate for user #{TEST_USER_ID} for course #{TEST_SOURCE_COURSE_ID}", match_requests_on: [:query]) do
        response = api.create_enrollments [{userid: TEST_USER_ID, entityid: TEST_SOURCE_COURSE_ID}], disallowduplicates: true, disallowsamestatusduplicates: true
        assert response.success?
        response_msg = response.dig("response", "responses", "response").first
        assert_equal "BadRequest", response_msg["code"]
        assert_equal "Duplicate enrollment", response_msg["message"]
      end
    end
  end

  describe "#delete_enrollment" do
    it "deletes a enrollment" do
      VCR.use_cassette("Commands::Enrollment delete_enrollment #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
       response =  api.delete_enrollments [{enrollmentid: TEST_ENROLLMENT_ID}]
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_enrollment" do
    it "gets an enrollment" do
      VCR.use_cassette("Commands::Enrollment get_enrollment #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
       response =  api.get_enrollment enrollmentid: TEST_ENROLLMENT_ID
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
       assert_equal TEST_ENROLLMENT_ID, response.dig("response", "enrollment", "id")
      end
    end
  end

  describe "#get_enrollment_activity" do
    it "gets an enrollment's activity" do
      VCR.use_cassette("Commands::Enrollment get_enrollment_activity #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
       response =  api.get_enrollment_activity enrollmentid: TEST_ENROLLMENT_ID
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
       assert response.dig("response", "enrollment")
      end
    end
  end

  describe "#get_enrollment_gradebook" do
    it "gets an enrollment's gradebook" do
      VCR.use_cassette("Commands::Enrollment get_enrollment_gradebook #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
       response =  api.get_enrollment_gradebook enrollmentid: TEST_ENROLLMENT_ID
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
       enrollment = response.dig("response", "enrollment")
       assert enrollment["grades"]
      end
    end
  end

  describe "#get_enrollment_group_list" do
    it "gets an enrollment's group list" do
      VCR.use_cassette("Commands::Enrollment get_enrollment_group_list #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
       response =  api.get_enrollment_group_list enrollmentid: TEST_ENROLLMENT_ID
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
       assert response.dig("response", "groups")
      end
    end
  end

  describe "#get_enrollment_metrics_report" do
    it "gets an enrollment's Student metric report for a domain" do
      VCR.use_cassette("Commands::Enrollment get_enrollment_metrics_report Student for domain  #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
       response =  api.get_enrollment_metrics_report entityid: TEST_DOMAIN_ID, report: "Student"
       assert response.success?
       assert_includes response.first, "user.id"
       assert_includes response.first, "coursecount"
      end
    end

    it "gets an enrollment's Enrollment metric report for a domain" do
      VCR.use_cassette("Commands::Enrollment get_enrollment_metrics_report Enrollment for domain  #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
       response =  api.get_enrollment_metrics_report entityid: TEST_DOMAIN_ID, report: "Enrollment"
       assert response.success?
       assert_includes response.first, "user.id"
       assert_includes response.first, "enrollment.id"
      end
    end
  end

  describe "#list_enrollments" do
    it "gets a list of all enrollments for a domain" do
      VCR.use_cassette("Commands::Enrollment list_enrollments for domain  #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
       response =  api.list_enrollments domainid: TEST_DOMAIN_ID
       assert response.success?
       enrollments = response.dig("response", "enrollments", "enrollment")
       assert_equal TEST_DOMAIN_ID, enrollments.sample["domainid"]
      end
    end
  end

  describe "#list_enrollments_by_teacher" do
    it "gets a list of all enrollments by teacher" do
      VCR.use_cassette("Commands::Enrollment list_enrollments_by_teacher ", match_requests_on: [:query]) do
       response =  api.list_enrollments_by_teacher
       assert response.success?
       enrollments = response.dig("response", "enrollments", "enrollment")
       assert enrollments
      end
    end
  end

  describe "#list_entity_enrollments" do
    it "gets a list of all enrollments by course (entity)" do
      VCR.use_cassette("Commands::Enrollment list_entity_enrollments for course #{TEST_SOURCE_COURSE_ID} ", match_requests_on: [:query]) do
       response =  api.list_entity_enrollments entityid: TEST_SOURCE_COURSE_ID
       assert response.success?
       enrollments = response.dig("response", "enrollments", "enrollment")
       assert_equal TEST_SOURCE_COURSE_ID , enrollments.sample["courseid"]
      end
    end
  end

  describe "#list_user_enrollments" do
    it "gets a list of all enrollments by user" do
      VCR.use_cassette("Commands::Enrollment list_user_enrollments for user #{TEST_USER_ID} ", match_requests_on: [:query]) do
       response =  api.list_user_enrollments userid: TEST_USER_ID
       assert response.success?
       enrollments = response.dig("response", "enrollments", "enrollment")
       assert_equal TEST_USER_ID , enrollments.sample["userid"]
      end
    end
  end

  describe "#put_self_assessment" do
    it "adds a self assessment rating for an enrollment" do
      VCR.use_cassette("Commands::Enrollment put_self_assessment for enrollment #{TEST_ENROLLMENT_ID} ", match_requests_on: [:query]) do
       response =  api.put_self_assessment enrollmentid: TEST_ENROLLMENT_ID, understanding: 200, effort: 220, interest: 100
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
      end
    end
  end


  describe "#restore_enrollment" do
    it "restores a deleted enrollment" do
      VCR.use_cassette("Commands::Enrollment restore_enrollment #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.restore_enrollment enrollmentid: TEST_ENROLLMENT_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#update_enrollments" do
    it "updates enrollment attributes" do
      VCR.use_cassette("Commands::Enrollment update_enrollments #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
        response = api.update_enrollments [{enrollmentid: TEST_ENROLLMENT_ID, status: 7}]
        assert response.success?
        updated_enrollments = response.dig("response", "responses", "response")
        assert_equal 1, updated_enrollments.count
      end
    end
  end



end
