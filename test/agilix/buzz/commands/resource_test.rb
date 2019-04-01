require "test_helper"

class Agilix::Buzz::Commands::ResourceTest < Minitest::Test

  describe "#copy_resources" do
    it "copy_resources" do
      VCR.use_cassette("Commands::Resource copy_resources from domain #{TEST_DOMAIN_ID} to domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.copy_resources [ {sourceentityid: TEST_DOMAIN_ID, destinationentityid: TEST_SUBDOMAIN_ID, sourcepath: "banner.css" }]
        assert_equal "OK", response.dig('response', 'code')
        assert_equal "OK", response.dig('response', 'responses', 'response').first['code']
      end
    end
  end

  describe "#delete_documents" do
    it "delete_documents" do
      skip
    end
  end

  describe "#delete_resources" do
    it "delete_resources" do
      skip
    end
  end

  describe "#get_document" do
    it "get_document" do
      skip
    end
  end

  describe "#get_document_info" do
    it "get_document_info" do
      skip
    end
  end

  describe "#get_entity_resource_id" do
    it "get_entity_resource_id" do
      skip
    end
  end

  describe "#get_resource" do
    it "get_resource" do
      VCR.use_cassette("Commands::Resource get_resource for domain #{TEST_SUBDOMAIN_ID} file #{TEST_FILE_NAME}", match_requests_on: [:query]) do
        response = api.get_resource entityid: TEST_SUBDOMAIN_ID, path: TEST_FILE_NAME
        assert response.success?
        binding.pry
        resources =  response.dig('response', 'resources', 'resource')
        assert_kind_of Array, resources
        assert_equal TEST_SUBDOMAIN_ID, resources.sample["entityid"]
      end
    end
  end

  describe "#get_resource_info2" do
    it "get_resource_info2" do
      skip
    end
  end

  describe "#get_resource_list2" do
    it "get_resource_list2" do
      VCR.use_cassette("Commands::Resource get_resource_list2 for domain #{TEST_SUBDOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_resource_list2 entityid: TEST_SUBDOMAIN_ID
        assert response.success?
        resources = response.dig('response', 'resources', 'resource')
        assert_kind_of Array, resources
        assert_equal TEST_SUBDOMAIN_ID, resources.sample["entityid"]
      end
    end
  end

  describe "#list_restorable_documents" do
    it "list_restorable_documents" do
      skip
    end
  end

  describe "#list_restorable_resources" do
    it "list_restorable_resources" do
      skip
    end
  end

  describe "#put_resource" do
    it "put_resource" do
      skip
    end
  end

  describe "#put_resource_folders" do
    it "put_resource_folders" do
      skip
    end
  end

  describe "#restore_documents" do
    it "restore_documents" do
      skip
    end
  end

  describe "#restore_resources" do
    it "restore_resources" do
      skip
    end
  end

end
