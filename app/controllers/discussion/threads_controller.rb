require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < InheritedResources::Base
    layout Discussion.layout
    include InheritedResources::DSL
    belongs_to :assignment, :polymorphic => true, :optional => true
    #TODO: need to make this dynamic

    respond_to :html, :xml, :json, :js
    actions :all, :except => [:edit]
    after_filter :mark_all_thread_messages_as_read, only: [:show]
    cache_sweeper :thread_sweeper

    destroy! do |success, failure|
      success.html { redirect_to_list }
      success.js { collection }
    end

    create! do |success, failure|
      mark_thread_as_read
      success.html { redirect_to_list }
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
    def redirect_to_list
      redirect_to parent? ? main_app.polymorphic_url([parent, :threads]) : threads_path
    end

    def build_resource
      super
      @thread.initiator = current_user
      @thread.messages.each { |m| m.author ||= current_user }
      @thread
    end

    def collection
      @threads ||= end_of_association_chain.order_by_recent.includes(:initiator)
      if params[:sent_item] == 'true'
        @threads = @threads.by_initiator(current_user)
      else
        @threads = @threads.concerns_with(current_user)
      end
      @threads = @threads.page(params[:page])
      @search = @threads.search(params[:q])
      @threads = @search.result
    end

    def mark_thread_as_read
      @thread.thread_reads.by(current_user).each { |tr| tr.update_attributes(read: true) }
    end

    def mark_all_thread_messages_as_read
      @thread.messages.each { |m| m.read_by!(current_user) if m.persisted? }
    end
  end
end