require_dependency 'issues_helper'

module IssuestreeviewIssuesHelperPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    
    ###
    # Compatibility helpers
    ###
    
    # Returns true if the method is defined, else it returns false
    def users_by_role_implemented
      return IssuesController.method_defined?("users_by_role")
    end

    # Returns true if the method is defined, else it returns false
    def authorize_global_implemented
      return ApplicationController.method_defined?("authorize_global")
    end

  end # Close the module ProjectstreeviewProjectsHelperPatch::InstanceMethods
end # Close the module ProjectstreeviewProjectsHelperPatch
