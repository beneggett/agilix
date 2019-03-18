require "test_helper"

class Agilix::Buzz::Commands::GeneralTest < Minitest::Test

  describe "#echo" do
    it "echos post commands to server" do
      VCR.use_cassette("Commands::General echo test", match_requests_on: [:query]) do
        response = api.echo domainid: 'my-id', username: 'user1', data: {auth: false}
        assert response.success?
        assert_equal "my-id", response.dig("request", "domainid")
        assert_equal "user1", response.dig("request", "username")
        refute response.dig("request", "data", "auth")
      end
    end
  end

  describe "#get_command_list" do
    it "gets list of all api commands" do
      VCR.use_cassette("Commands::General get_command_list", match_requests_on: [:query]) do
        response = api.get_command_list
        assert response.success?
        commands = response.dig('response', 'commands', 'command')
        assert commands
        # this might be a stupid test, but there are 447 commands at time of writing
        assert_includes commands.map {|x| x["name"]}, "login2"
        assert_equal 447, commands.count
      end
    end
  end

  describe "#get_entity_type" do
    it "looks up an entity type for id" do
      VCR.use_cassette("Commands::General get_entity_type #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_entity_type entityid: TEST_DOMAIN_ID
        assert response.success?
        assert_equal "Domain", response.dig("response", "entity", "entitytype")
      end
    end
  end

  describe "#get_status" do
    it "gets detailed status on health of buzz app" do
      VCR.use_cassette("Commands::General get_status", match_requests_on: [:query]) do
        response = api.get_status rating: 4, html: true, sms: true
        assert response.success?
        status = response.dig('response', 'status')
        assert_equal "OK", status.dig('overall', 'status')
        assert status.dig('overall', 'sms')
      end
    end
  end

  describe "#get_basic_status" do
    it "gets basic status on health of buzz app (non-authenticated call)" do
      VCR.use_cassette("Commands::General get_basic_status", match_requests_on: [:query]) do
        response = api.get_basic_status
        assert response.success?
        status = response.dig('response', 'status')
        assert_equal "OK", status.dig('overall', 'status')
      end
    end
  end

  describe "#get_upload_limits" do
    it "gets upload limits. API doesn't work" do
      VCR.use_cassette("Commands::General get_upload_limits", match_requests_on: [:query]) do
        response = api.get_upload_limits
        assert response.success?
        status = response.dig('response', 'code')
        assert_equal "AccessDenied", status
      end
    end
  end

  describe "#send_mail" do
    it "Sends an email to enrollees of a group where an enrollee exists" do
      VCR.use_cassette("Commands::General send_mail #{TEST_ENROLLMENT_ID}", match_requests_on: [:query]) do
        response = api.send_mail subject: "Test email", body: "Did you get this?", enrollmentid: TEST_ENROLLMENT_ID, enrollment_ids: ["all"]
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end

    it "Sends an email to enrollees of a group where an enrollee exists with custom strings" do
      VCR.use_cassette("Commands::General send_mail #{TEST_ENROLLMENT_ID} custom strings", match_requests_on: [:query]) do
        response = api.send_mail subject: "Test email", body: "Did you get this?", enrollmentid: TEST_ENROLLMENT_ID, enrollment_ids: ["all"], strings: {norecipients: "No Recipients match your request"}
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end




end
