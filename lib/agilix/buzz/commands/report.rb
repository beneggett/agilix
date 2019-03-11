module Agilix
  module Buzz
    module Commands
      module Report

        # Use this one to find reports you can run
        # api.get_runnable_report_list domainid: 57025
        def get_runnable_report_list(options = {})
          options = argument_cleaner(required_params: %i( ), optional_params: %i( entityid domainid ), options: options )
          authenticated_get cmd: "getrunnablereportlist", **options
        end

        # Use this one to run a report
        # api.run_report reportid: 127, entityid: 57025
        def run_report(options = {})
          options = argument_cleaner(required_params: %i( reportid entityid ), optional_params: %i( format content_disposition nodata AsOf), options: options )
          authenticated_get cmd: "runreport", **options
        end

        # slightly more info than get_runnable_report_list
        # api.get_report_info reportid: 123
        def get_report_info(options = {})
          options = argument_cleaner(required_params: %i( reportid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getreportinfo", **options
        end

        # This call seems worthless, and we don't seem to have rights
        # api.get_report_list domainid: 1
        def get_report_list(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getreportlist", **options
        end

      end
    end
  end
end
