require_dependency "discussion/application_controller"

module Discussion
  class CommentsController < InheritedResources::Base
    layout Discussion.layout
    respond_to :html, :xml, :json, :js
    include InheritedResources::DSL

    nested_belongs_to :thread, parent_class: Discussion::Thread
    actions :all, :except => [:edit, :update]

    create! do |success, failure|
      success.html { redirect_to :back }
    end

    private
    def build_resource
      super
      @comment.author = current_user
      @comment
    end
  end
end