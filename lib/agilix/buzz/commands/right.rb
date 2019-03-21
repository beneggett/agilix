module Agilix
  module Buzz
    module Commands
      module Right

        # ISSUE: Why is this create singular, not multiple?
        # api.create_role domainid: 57025, name: "Test Role", privileges: api.right_flags[:create_domain]
        def create_role(options = {})
          options = argument_cleaner(required_params: %i( domainid name privileges ), optional_params: %i( reference entitytype ), options: options )
          raise ArgumentError.new("Not a valid entitytype. Should be D,C, or empty") unless [nil, "", "D", "C"].include?(options[:entitytype])
          authenticated_post cmd: "createrole", **options
        end

        # api.delete_role roleid: 61316
        def delete_role(options = {})
          options = argument_cleaner(required_params: %i( roleid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "deleterole", **options
        end

        # api.delete_subscriptions
        def delete_subscriptions(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "deletesubscriptions", **options
        end

        # api.get_actor_rights
        def get_actor_rights(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getactorrights", **options
        end

        # api.get_effective_rights
        def get_effective_rights(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "geteffectiverights", **options
        end

        # api.get_effective_subscription_list
        def get_effective_subscription_list(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "geteffectivesubscriptionlist", **options
        end

        # api.get_entity_rights
        def get_entity_rights(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getentityrights", **options
        end

        # api.get_entity_subscription_list
        def get_entity_subscription_list(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getentitysubscriptionlist", **options
        end

        # api.get_personas
        def get_personas(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getpersonas", **options
        end

        # api.get_rights
        def get_rights(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getrights", **options
        end

        # api.get_rights_list
        def get_rights_list(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getrightslist", **options
        end

        # api.get_role
        def get_role(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getrole", **options
        end

        # api.get_subscription_list
        def get_subscription_list(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getsubscriptionlist", **options
        end

        # api.list_roles domainid: 57025
        def list_roles(options = {})
          options = argument_cleaner(required_params: %i( domainid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "listroles", **options
        end

        # api.restore_role roleid: 61316
        def restore_role(options = {})
          options = argument_cleaner(required_params: %i( roleid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "restorerole", **options
        end

        # api.update_rights
        def update_rights(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "updaterights", **options
        end

        # api.update_role roleid: 61316, name: "Test Role Updates", privileges: api.right_flags[:update_domain]
        def update_role(options = {})
          options = argument_cleaner(required_params: %i( roleid  ), optional_params: %i( name privileges reference entitytype ), options: options )
          raise ArgumentError.new("Not a valid entitytype. Should be D,C, or empty") unless [nil, "", "D", "C"].include?(options[:entitytype])

          authenticated_post cmd: "updaterole", **options
        end

        # api.update_subscriptions
        def update_subscriptions(options = {})
          options = argument_cleaner(required_params: %i( rightid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "updatesubscriptions", **options
        end


        def right_flags
          {
            admin: -1,
            none: 0,
            participate: 1,
            create_domain: 16,
            read_domain: 32,
            update_domain: 64,
            delete_domain: 128,
            create_user: 256,
            read_user: 512,
            update_user: 1024,
            delete_user: 2048,
            create_course: 65536,
            read_course: 131072,
            update_course: 262144,
            delete_course: 524288,
            create_section: 1048576,
            read_section: 2097152,
            update_section: 4194304,
            delete_section: 8388608,
            grade_assignment: 16777216,
            grade_forum: 33554432,
            grade_exam: 67108864,
            setup_gradebook: 134217728,
            control_domain: 268435456,
            control_course: 536870912,
            control_section: 1073741824,
            read_gradebook: 2147483648,
            report_domain: 4294967296,
            report_course: 8589934592,
            report_section: 17179869184,
            post_domain_announcements: 34359738368,
            proxy: 68719476736,
            report_user: 274877906944,
            submit_final_grade: 549755813888,
            control_enrollment: 1099511627776,
            read_enrollment: 2199023255552,
            read_course_full: 4398046511104,
            control_user: 8796093022208,
            read_objective: 17592186044416,
            update_objective: 35184372088832
          }
        end

        def right_flags_hex
          {
            admin: "-0x01",
            none: "0x00",
            participate: "0x01",
            create_domain: "0x10",
            read_domain: "0x20",
            update_domain: "0x40",
            delete_domain: "0x80",
            create_user: "0x100",
            read_user: "0x200",
            update_user: "0x400",
            delete_user: "0x800",
            create_course: "0x10000",
            read_course: "0x20000",
            update_course: "0x40000",
            delete_course: "0x80000",
            create_section: "0x100000",
            read_section: "0x200000",
            update_section: "0x400000",
            delete_section: "0x800000",
            grade_assignment: "0x1000000",
            grade_forum: "0x2000000",
            grade_exam: "0x4000000",
            setup_gradebook: "0x8000000",
            control_domain: "0x10000000",
            control_course: "0x20000000",
            control_section: "0x40000000",
            read_gradebook: "0x80000000",
            report_domain: "0x100000000",
            report_course: "0x200000000",
            report_section: "0x400000000",
            post_domain_announcements: "0x800000000",
            proxy: "0x1000000000",
            report_user: "0x4000000000",
            submit_final_grade: "0x8000000000",
            control_enrollment: "0x10000000000",
            read_enrollment: "0x20000000000",
            read_course_full: "0x40000000000",
            control_user: "0x80000000000",
            read_objective: "0x100000000000",
            update_objective: "0x200000000000"
          }
        end


        def right_flags_lookup_value(val)
          val = val.to_s
          if val.include?("x")
            raise ArgumentError.new("Not a valid right flag") unless right_flags_hex.values.include?(val)
            right_flags_hex.find {|k,v| v == val}.first
          else
            val = val.to_i
            raise ArgumentError.new("Not a valid right flag") unless right_flags.values.include?(val)
            right_flags.find {|k,v| v == val}.first
          end
        end

      end
    end
  end
end
