  module Agilix
  module Buzz
    module Commands
      module Resource

        # "Discuss.png"
        def copy_resources(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( sourceentityid destinationentityid ), optional_params: %i( sourcepath destinationpath ), options: item )
          end
          authenticated_bulk_post cmd: "copyresources", root_node: "resource", body: options
        end

        # api.delete_documents
        def delete_documents(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "deletedocuments", **options
        end

          # api.delete_resources [{entityid: 57031, path: 'banner.css'}]
        def delete_resources(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( entityid path ), optional_params: %i( class ), options: item )
          end
          authenticated_bulk_post cmd: "deleteresources", root_node: "resource", body: options
        end

        # api.get_document
        def get_document(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getdocument", **options
        end

        # api.get_document_info
        def get_document_info(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getdocumentinfo", **options
        end

        # api.get_entity_resource_id entityid: 57025
        def get_entity_resource_id(options = {})
          options = argument_cleaner(required_params: %i( entityid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "getentityresourceid", **options
        end

        # api.get_resource entityid: 57031, path: "banner.css"
        def get_resource(options = {})
          options = argument_cleaner(required_params: %i( entityid path ), optional_params: %i( version packagetype attachment class ), options: options )
          authenticated_get cmd: "getresource", **options
        end

        # ISSUE: This is a get request with a POST verb. The documentation only suggests getting a single resoure, so I'm not sure why it would be a bulk post syntax. it does seem to respond to multiple resources though,so we'll adapt
        # api.get_resource_info  [{entityid: 57031, path: "banner.css"}]
        def get_resource_info2(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( entityid path ), optional_params: %i( class ), options: item )
          end
          authenticated_bulk_post cmd: "getresourceinfo2", root_node: "resource", body: options
        end
        alias_method :get_resource_info, :get_resource_info2

        # api.get_resource_list2 entityid: 57025
        def get_resource_list2(options = {})
          options = argument_cleaner(required_params: %i( entityid ), optional_params: %i( path recurse query allversions entries class ), options: options )
          authenticated_get cmd: "getresourcelist2", **options
        end
        alias_method :get_resource_list, :get_resource_list2

        # api.list_restorable_documents
        def list_restorable_documents(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "listrestorabledocuments", **options
        end

        # api.list_restorable_resources
        def list_restorable_resources(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "listrestorableresources", **options
        end

        # api.put_resource
        def put_resource(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "putresource", **options
        end

        # api.put_resource_folders
        def put_resource_folders(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "putresourcefolders", **options
        end

        # api.restore_documents
        def restore_documents(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "restoredocuments", **options
        end

        # api.restore_resources
        def restore_resources(options = {})
          options = argument_cleaner(required_params: %i( resourceid ), optional_params: %i( ), options: options )
          authenticated_get cmd: "restoreresources", **options
        end

      end
    end
  end
end
