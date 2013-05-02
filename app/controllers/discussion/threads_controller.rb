require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < InheritedResources::Base
    include InheritedResources::DSL
    respond_to :html, :xml, :json, :js
    actions :all, :except => [:edit, :update]
    after_filter :mark_thread_as_read, only: [:show]

    destroy! do |success, failure|
      success.js { collection }
    end

    protected
    def build_resource
      super
      @thread.initiator = current_user
      @thread.messages.each { |m| m.author ||= current_user }
      @thread
    end

    def collection
      @threads ||= end_of_association_chain.concerns_with(current_user).order_by_recent.
          includes(:initiator).page(params[:page])
      @search = @threads.search(params[:q])
      @threads = @search.result
    end

    def mark_thread_as_read
      @thread.messages.each { |m| m.read_by!(current_user) }
    end
  end
end