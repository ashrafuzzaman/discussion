module Discussion
  module CommentsHelper
    def load_comments_for(commentable, options={})
      lazy = options[:lazy] || false
      if lazy
        comments_container_id = "comments-#{Time.now.to_i}"
        content_tag :div, id: comments_container_id do
        end
      else
        render :partial => "discussion/comments/list_with_form", locals: {commentable: commentable}
      end
    end
  end
end