require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < InheritedResources::Base
    actions :all, :except => [:edit, :update]

    private
    def build_resource
      super
      @thread.initiator = current_user
      @thread.messages.each { |m| m.author ||= current_user }
      @thread
    end
  end
end