module Discussion
  module CommentsHelper
    def load_comments_for(commentable, options={})
      remote = options[:remote] || false
      if remote
        comments_container_id = "comments-#{Time.now.to_i}"
        <<-EOF.html_safe
        <div id='#{comments_container_id}' class="comments_container">Loading comments ...</div>
        <script type='text/javascript'>
          Disussion.loadComments('#{polymorphic_url([commentable, :comments])}', '#{comments_container_id}');
        </script>
        EOF
      else
        render :partial => "discussion/comments/list_with_form", locals: {commentable: commentable}
      end
    end
  end
end