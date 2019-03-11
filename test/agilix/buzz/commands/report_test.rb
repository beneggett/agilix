require "test_helper"

class Agilix::Buzz::Commands::ReportTest < Minitest::Test

  describe "#get_runnable_report_list" do
    it "gets a list of reports you can run" do
      VCR.use_cassette("Commands::Report get_runnable_report_list", match_requests_on: [:query]) do
        response = api.get_runnable_report_list domainid: 57025
        assert response.success?
        reports = response.dig("response", "reports", "report")
        assert_equal 9, reports.size
      end
    end
  end

  describe "#run_report" do
    it "runs a specific report" do
      VCR.use_cassette("Commands::Report run_report 127 on 57025", match_requests_on: [:query]) do
        response = api.run_report reportid: 127, entityid: 57025, format: 'json'
        assert response.success?
        report = response.dig("response", "report")
        assert_equal 127, report["reportid"]
        assert_equal "57025", report.dig("parameters", "parameter").find {|param| param["name"] == "EntityId"}&.dig("value")
      end
    end
  end

  describe "#get_report_info" do
    it "looks up info about a report you can run" do
      VCR.use_cassette("Commands::Report get_report_info", match_requests_on: [:query]) do
        response = api.get_report_info reportid: 127
        assert response.success?
        report = response.dig("response", "report")
        assert_equal "127", report["reportid"]
      end
    end
  end

  describe "#get_report_list" do
    it "is a worthless report list that doesn't work" do
      VCR.use_cassette("Commands::Report get_report_list", match_requests_on: [:query]) do
        response = api.get_report_list domainid: 1
        assert response.success?
        assert_equal "AccessDenied", response.dig("response", "code")
      end
    end
  end


end
