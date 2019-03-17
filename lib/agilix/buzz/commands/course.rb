module Agilix
  module Buzz
    module Commands
      module Course

        # api.copy_courses courseid: 54, domainid: 57025
        def copy_courses(options = {})
          options = argument_cleaner(required_params: %i( courseid domainid ), optional_params: %i( action depth reference status roleid title type startdate enddate days term indexrule ), options: options )
          authenticated_bulk_post cmd: "copycourses", root_node: "course", body: options
        end

        # api.create_courses
        def create_courses(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "createcourses", **options
        end

        # api.create_demo_course
        def create_demo_course(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "createdemocourse", **options
        end

        # api.deactivate_course
        def deactivate_course(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "deactivatecourse", **options
        end

        # api.delete_courses
        def delete_courses(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "deletecourses", **options
        end

        # api.get_course2
        def get_course2(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getcourse2", **options
        end

        # api.get_course_history
        def get_course_history(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getcoursehistory", **options
        end

        # api.list_courses domainid: 5
        def list_courses(options = {})
          options[:domainid] ||= 0
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( includedescendantdomains limit show select text query subtype subscriptionmode subscriptiondomainid ), options: options )
          authenticated_get cmd: "listcourses", **options
        end

        # api.merge_courses
        def merge_courses(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "mergecourses", **options
        end

        # api.restore_course
        def restore_course(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "restorecourse", **options
        end

        # api.update_courses
        def update_courses(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "updatecourses", **options
        end

      end
    end
  end
end
