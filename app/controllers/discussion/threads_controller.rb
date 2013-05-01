require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < ApplicationController
    # GET /threads
    # GET /threads.json
    def index
      @threads = Thread.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @threads }
      end
    end
  
    # GET /threads/1
    # GET /threads/1.json
    def show
      @thread = Thread.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @thread }
      end
    end
  
    # GET /threads/new
    # GET /threads/new.json
    def new
      @thread = Thread.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @thread }
      end
    end
  
    # GET /threads/1/edit
    def edit
      @thread = Thread.find(params[:id])
    end
  
    # POST /threads
    # POST /threads.json
    def create
      @thread = Thread.new(params[:thread])
  
      respond_to do |format|
        if @thread.save
          format.html { redirect_to @thread, notice: 'Thread was successfully created.' }
          format.json { render json: @thread, status: :created, location: @thread }
        else
          format.html { render action: "new" }
          format.json { render json: @thread.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /threads/1
    # PUT /threads/1.json
    def update
      @thread = Thread.find(params[:id])
  
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
  
    # DELETE /threads/1
    # DELETE /threads/1.json
    def destroy
      @thread = Thread.find(params[:id])
      @thread.destroy
  
      respond_to do |format|
        format.html { redirect_to threads_url }
        format.json { head :no_content }
      end
    end
  end
end
