module Agilix
  module Buzz
    module Commands
      module Course

        # api.copy_courses [{courseid: 54, domainid: 57025}]
        def copy_courses(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( courseid domainid ), optional_params: %i( action depth reference status roleid title type startdate enddate days term indexrule ), options: item )
          end
          authenticated_bulk_post cmd: "copycourses", root_node: "course", body: options
        end

        # api.create_courses title: "Starter Course", domainid: 57025
        def create_courses(items = [])
          options = items.map do |item|
            item[:schema] ||= 3 # should default to 3, 2 is old news
            argument_cleaner(required_params: %i( title domainid schema ), optional_params: %i(reference status roleid type startdate enddate days term indexrule data ), options: item )
          end
          authenticated_bulk_post cmd: "createcourses", root_node: "course", body: options
        end

        # ISSUE: documentation on request format is inconsistent, not sure if it is bulk post or normal post format. in one place rood node is request, in other its course
        # api.create_demo_course courseid: 60982, domainid: 57025, title: "Demo Course", daysoffset: 60
        def create_demo_course(options = {})
          options = argument_cleaner(required_params: %i( courseid domainid ), optional_params: %i( schema reference title daysoffset usermap ), options: options )
          authenticated_post cmd: "createdemocourse", **options
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
