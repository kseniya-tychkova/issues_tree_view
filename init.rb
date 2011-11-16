require 'redmine'

# Patches to the Redmine core.
require 'dispatcher'
require 'issuestreeview_issues_helper_patch'
Dispatcher.to_prepare do
  ProjectsHelper.send(:include, IssuestreeviewIssuesHelperPatch)
end

Redmine::Plugin.register :issues_tree_view do
  name 'Issues Tree View plugin'
  author 'Kseniya Tychkova'
  description 'This is a Redmine plugin which will turn the isues page into a tree view'
  version '0.0.1'
end

class IssuesTreeViewListener < Redmine::Hook::ViewListener

  # Adds javascript and stylesheet tags
  def view_layouts_base_html_head(context)
    javascript_include_tag('issues_tree_view', :plugin => :issues_tree_view) +
    stylesheet_link_tag('issues_tree_view', :plugin => :issues_tree_view)
  end
  
end
