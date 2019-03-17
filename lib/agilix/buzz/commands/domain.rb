module Agilix
  module Buzz
    module Commands
      module Domain

        # api.create_domains [{name: "BuzzTest1", userspace: 'buzz-test-fc-1', parentid: '57025'}]
        def create_domains(items = [])
          options = items.map do |item|
            options = argument_cleaner(required_params: %i( name userspace parentid ), optional_params: %i( reference flags data ), options: item )
          end
          authenticated_bulk_post cmd: "createdomains", root_node: 'domain', body: options
        end

        # api.delete_domain domainid: '57031'
        def delete_domain(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "deletedomain", **options
        end

        # api.get_domain domainid: '57025'
        def get_domain2(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( select ), options: options )
          authenticated_get cmd: "getdomain2", **options
        end
        alias_method :get_domain, :get_domain2

        # api.get_domain_content domainid: '57025'
        def get_domain_content(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getdomaincontent", **options
        end

        # api.get_domain_enrollment_metrics domainid: '57025'
        def get_domain_enrollment_metrics(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( skipempty ), options: options )
          authenticated_get cmd: "getdomainenrollmentmetrics", **options
        end

        # api.get_domain_parent_list domainid: '57025'
        def get_domain_parent_list(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getdomainparentlist", **options
        end

        # api.get_domain_settings domainid: '57025', path: "AgilixBuzzSettings.xml"
        def get_domain_settings(options = {})
          options = argument_cleaner(required_params: %i( domainid path ), optional_params: %i( includesource ), options: options )
          authenticated_get cmd: "getdomainsettings", **options
        end
        # Optional can use settings in a POST to set settings attributes if needed.

        # api.get_domain_stats domainid: '57025', options: "users|courses"
        def get_domain_stats(options = {})
          # options = 'users|courses|activecourses|sections|enrollments|activeenrollments|activestudents'
          options = argument_cleaner(required_params: %i( domainid options ), optional_params: %i( includesource ), options: options )

          authenticated_get cmd: "getdomainstats", **options
        end

        # api.list_domains domainid: '0' # all domains for user
        # api.list_domains domainid: '57025'
        def list_domains(options = {})
          options[:domainid] ||= 0
          options = argument_cleaner(required_params: %i( domainid  ), optional_params: %i( includedescendantdomains limit show select text query ), options: options )
          authenticated_get cmd: "listdomains", **options
        end

        # api.restore_domain domainid: '57031'
        def restore_domain(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "restoredomain", **options
        end

        # api.update_domains [{ domainid: "57031", name: "BuzzTestUpdated1", userspace: 'buzz-test-fc-1', parentid: '57025'}]
        def update_domains(items)
          options = items.map do |item|
            options = argument_cleaner(required_params: %i( domainid  ), optional_params: %i( name userspace parentid reference flags data ), options: item )
          end
          authenticated_bulk_post cmd: "updatedomains", root_node: 'domain', body: options
        end

      end
    end
  end
end
