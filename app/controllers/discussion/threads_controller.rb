require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < InheritedResources::Base
    actions :all, :except => [:edit, :update]
    after_filter :mark_thread_as_read, only: [:show]

    private
    def build_resource
      super
      @thread.initiator = current_user
      @thread.messages.each { |m| m.author ||= current_user }
      @thread
    end

    def mark_thread_as_read
      @thread.messages.each { |m| m.read_by!(current_user) }
    end
  end
end