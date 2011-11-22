require_dependency 'issues_helper'

module IssuestreeviewIssuesHelperPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
  end

  module InstanceMethods   

    def show_hierarchy?
      if  params && params[:hierarchy] && params[:hierarchy] == "1"
        return true
      else
        return false
      end
    end

    def issues_tree(query, offset, limit)
      issues = query.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version],
                            :order => "root_id, issues.lft",
                            :offset => offset,
                            :limit => limit)
    end
 
    def issues_ancestors(issues, &block)
      ancestors = []
      issues.each do |issue|
        while (ancestors.any? && !issue.is_descendant_of?(ancestors.last))
          ancestors.pop
        end
        yield issue, ancestors
        ancestors << issue unless issue.leaf?
      end
    end
 
    def has_children_in?(array, issue)
      array.detect{|i| i.parent_id == issue.id}
    end

    def has_parent_in?(array, issue)
      if issue.parent_id
        array.detect{|i| i.id == issue.parent_id}
      else
        return false
      end
    end

  end
end
