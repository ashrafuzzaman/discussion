require_dependency "discussion/application_controller"

module Discussion
  class MessagesController < InheritedResources::Base
    before_filter :authenticate_user!

    respond_to :html, :xml, :json, :js
    include InheritedResources::DSL

    nested_belongs_to :thread, parent_class: Discussion::Thread
    actions :all, :except => [:edit, :update]

    create! do |success, failure|
      success.html { redirect_to @thread }
    end

    private
    def build_resource
      super
      @message.author = current_user
      @message
    end
  end
end