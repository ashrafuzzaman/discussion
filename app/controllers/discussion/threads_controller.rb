require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < InheritedResources::Base
    before_filter :authenticate_user!

    include InheritedResources::DSL
    respond_to :html, :xml, :json, :js
    actions :all, :except => [:edit]
    after_filter :mark_all_thread_messages_as_read, only: [:show]

    destroy! do |success, failure|
      success.js { collection }
    end

    def show
      show! do |format|
        mark_thread_as_read
        format.html
        format.js
      end
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
      @thread.thread_reads.by(current_user).update_all(read: true)
    end

    def mark_all_thread_messages_as_read
      @thread.messages.each { |m| m.read_by!(current_user) if m.persisted? }
    end
  end
end