require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < ApplicationController
    layout Discussion.layout
    respond_to :html, :xml, :json, :js
    cache_sweeper :thread_sweeper

    before_filter :load_thread, only: [:show, :edit, :update, :destroy]

    def index
      @threads = collection
      respond_with(@threads)
    end

    def show
      mark_thread_as_read
      mark_all_thread_comments_as_read

      respond_with(@thread)
    end

    def new
      build_resource
      respond_with(@thread)
    end

    def edit
    end

    def create
      build_resource
      respond_to do |format|
        if @thread.save
          mark_thread_as_read
          format.html { redirect_to_list }
          format.js { collection }
          format.json { render json: @thread, status: :created, location: @thread }
        else
          format.html { render action: "new" }
          format.json { render json: @thread.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @thread.update_attributes(params[:thread])
          format.html { redirect_to @thread, notice: 'Thread was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @thread.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @thread.destroy
      respond_to do |format|
        format.html { redirect_to_list }
        format.js { collection }
        format.json { head :no_content }
      end
    end

    protected

    def threadable
      return @threadable if @threadable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          @threadable = $1.classify.constantize.find(value)
          return @threadable
        end
      end
      nil
    end

    def threadable?
      threadable.present?
    end

    def thread_builder
      threadable? ? threadable.threads : Thread
    end

    def load_thread
      @thread = thread_builder.find(params[:id])
    end

    def redirect_to_list
      redirect_to threadable? ? main_app.polymorphic_url([@threadable, :threads]) : threads_path
    end

    def build_resource
      @thread = thread_builder.new(params[:thread])
      @thread.initiator = current_user
      @thread.comments.each { |m| m.author ||= current_user }
      @thread
    end

    def collection
      @threads = thread_builder.order_by_recent.includes(:initiator)
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

    def mark_all_thread_comments_as_read
      @thread.comments.each { |m| m.read_by!(current_user) if m.persisted? }
    end
  end
end