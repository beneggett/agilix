module Agilix
  module Buzz
    module Commands
      module Enrollment

        def enrollment_status
          {
            active: 1,
            withdrawn: 4,
            withdrawn_failed: 5,
            transferred: 6,
            completed: 7,
            completed_no_credit: 8,
            suspended: 9,
            inactive: 10
          }
        end

        def enrollment_status_lookup_value(int)
          int = int.to_i
          raise ArgumentError.new("Not a valid enrollment status code") unless enrollment_status.values.include?(int)
          enrollment_status.find {|k,v| v == int}.first
        end

        # ISSUE: API format is very inconsistent on this one, requires both query string modification & body modification
        # api.create_enrollments [{userid: 57026, entityid: 57025}]
        def create_enrollments(items = [], disallowduplicates: false, disallowsamestatusduplicates: false )
          options = items.map do |item|
            item[:status] ||= 1
            argument_cleaner(required_params: %i( userid entityid status ), optional_params: %i( roleid flags domainid startdate enddate reference schema data ), options: item )
          end
          if [disallowduplicates, disallowsamestatusduplicates].compact.any?
            query_params = {}
            query_params[:disallowduplicates] = disallowduplicates
            query_params[:disallowsamestatusduplicates] = disallowsamestatusduplicates
          end
          authenticated_bulk_post cmd: "createenrollments", root_node: 'enrollment', query_params: query_params, body: options
        end

        # ISSUE: Inconsistent from other delete apis. many are singular, not plural
        # api.delete_enrollments [ { enrollmentid: 60997 }]
        def delete_enrollments(items = {})
          options = items.map do |item|
            argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( ), options: item )
          end
          authenticated_bulk_post cmd: "deleteenrollments", root_node: 'enrollment', body: options
        end

        # api.get_enrollment enrollmentid: 60997
        def get_enrollment3(options = {})
          options = argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( select ), options: options )
          authenticated_get cmd: "getenrollment3", **options
        end
        alias_method :get_enrollment, :get_enrollment3

        # api.get_enrollment_activity enrollmentid: 60997
        def get_enrollment_activity(options = {})
          options = argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( last mergeoverlap ), options: options )
          authenticated_get cmd: "getenrollmentactivity", **options
        end

        # api.get_enrollment_gradebook enrollmentid: 60997
        def get_enrollment_gradebook2(options = {})
          options = argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( forcerequireditems gradingschemeid gradingscheme itemid scorm zerounscored ), options: options )
          authenticated_get cmd: "getenrollmentgradebook2", **options
        end
        alias_method :get_enrollment_gradebook, :get_enrollment_gradebook2

        # api.get_enrollment_group_list enrollmentid: 60997
        def get_enrollment_group_list(options = {})
          options = argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( setid ), options: options )
          authenticated_get cmd: "getenrollmentgrouplist", **options
        end

        # api.get_enrollment_metrics_report entityid: 50725, report: "Student"
        # api.get_enrollment_metrics_report entityid: 50725, report: "Enrollment"
        def get_enrollment_metrics_report(options = {})
          raise ArgumentError.new("report can only be Student or Enrollment") unless ['Student', 'Enrollment'].include?(options[:report])
          default_select = %w( user.id user.firstname user.lastname user.username user.reference)
          student_select = %w( coursecount latecount failedcount paceyellows pacereds performanceyellows performancereds)
          enrollment_select = %w(enrollment.id course.title course.id course.reference score achieved possible failing seconds completable completed gradable completedgradable graded percentcomplete late failed recentlyfailed pacelight pacereason performancelight performancereason lastduedatemissed calculateddate )
          if options[:report] == "Student"
            options[:select] ||= (default_select + student_select).flatten.join(",")
          elsif options[:report] == "Enrollment"
            options[:select] ||= (default_select + enrollment_select).flatten.join(",")
          end
          options = argument_cleaner(required_params: %i( entityid report select  ), optional_params: %i( filename format ), options: options )
          authenticated_get cmd: "getenrollmentmetricsreport", **options
        end

        # api.list_enrollments domainid: 50725
        def list_enrollments(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( includedescendantdomains limit show select query userdomainid userquery usertext coursedomainid coursequery coursetext ), options: options )
          authenticated_get cmd: "listenrollments", **options
        end

        # api.list_enrollments_by_teacher teacheruserid: 50726
        # api.list_enrollments_by_teacher
        def list_enrollments_by_teacher(options = {})
          options = argument_cleaner(required_params: %i(  ), optional_params: %i( teacheruserid teacherallstatus teacherdaysactivepastend privileges allstatus daysactivepastend userid select ), options: options )
          authenticated_get cmd: "listenrollmentsbyteacher", **options
        end

        # api.list_entity_enrollments entityid: 60982
        def list_entity_enrollments(options = {})
          options = argument_cleaner(required_params: %i( entityid ), optional_params: %i( privileges allstatus daysactivepastend userid select ), options: options )
          authenticated_get cmd: "listentityenrollments", **options
        end

        # api.list_user_enrollments userid: 57181
        def list_user_enrollments(options = {})
          options = argument_cleaner(required_params: %i( userid ), optional_params: %i( allstatus entityid privileges daysactivepastend query select ), options: options )
          authenticated_get cmd: "listuserenrollments", **options
        end

        # ISSUE: this should be a post, not a get
        # api.put_self_assessment enrollmentid: 60997, understanding: 200, effort: 220, interest: 100
        def put_self_assessment(options = {})
          options = argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( understanding interest effort ), options: options )
          authenticated_get cmd: "putselfassessment", **options
        end

        # api.restore_enrollment enrollmentid: 60997
        def restore_enrollment(options = {})
          options = argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "restoreenrollment", **options
        end

        # api.update_enrollments [{enrollmentid: 60997, status: 7}]
        def update_enrollments(items)
          options = items.map do |item|
            argument_cleaner(required_params: %i( enrollmentid ), optional_params: %i( userid entityid domainid roleid flags status startdate enddate reference schema data ), options: item)
          end
          authenticated_bulk_post cmd: "updateenrollments", root_node: 'enrollment', body: options
        end


        # # api.update_users  [{ userid: '57026', username: "BuzzUserTestUpdated1", email: 'buzzusertest1@agilix.com',firstname: 'Buzz', lastname: "ManUpdated"}]
        # def update_users
        # end

      end
    end
  end
end
