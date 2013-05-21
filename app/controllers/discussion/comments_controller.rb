require_dependency "discussion/application_controller"

module Discussion
  class CommentsController < InheritedResources::Base
    layout Discussion.layout
    respond_to :html, :xml, :json, :js

    before_filter :load_comment, only: [:show, :edit, :update, :destroy]

    def index
      @comments = collection
      respond_with(@comments)
    end

    def show
      respond_with(@comment)
    end

    def new
      build_resource
      respond_with(@comment)
    end

    def edit
    end

    def create
      build_resource
      respond_to do |format|
        if @comment.save
          format.html { redirect_to :back }
          format.js { collection }
          format.json { render json: @comment, status: :created, location: @comment }
        else
          format.html { render action: "new" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @comment.update_attributes(params[:comment])
          format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.js { collection }
        format.json { head :no_content }
      end
    end

    protected

    def commentable
      return @commentable if @commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          klass = $1 == 'thread' ? Discussion::Thread : $1.classify.constantize
          @commentable = klass.find(value)
          return @commentable
        end
      end
      nil
    end

    def commentable?
      commentable.present?
    end

    def comment_builder
      commentable? ? commentable.comments : comment
    end

    def load_comment
      @comment = comment_builder.find(params[:id])
    end

    def redirect_to_list
      redirect_to commentable? ? main_app.polymorphic_url([@commentable, :comments]) : comments_path
    end

    def build_resource
      @comment = comment_builder.new(params[:comment])
      @comment.author = current_user
      @comment
    end

    def collection
      @comments = comment_builder.order_by_recent.includes(:initiator)
      if params[:sent_item] == 'true'
        @comments = @comments.by_initiator(current_user)
      else
        @comments = @comments.concerns_with(current_user)
      end
      @comments = @comments.page(params[:page])
      @search = @comments.search(params[:q])
      @comments = @search.result
    end
  end
end