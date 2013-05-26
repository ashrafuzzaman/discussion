module Discussion
  module CommentsHelper
    def load_comments_for(commentable, options={})
      lazy = options[:lazy] || false
      if lazy
        comments_container_id = "comments-#{Time.now.to_i}"
        <<-EOF.html_safe
        <div id='#{comments_container_id}'></div>
        <script type='text/javascript'>
          //Disussion.loadComments('#{main_app.polymorphic_url([commentable, :comments])}', '#{comments_container_id}');
          jQuery.ajax({
            url: '#{main_app.polymorphic_url([commentable, :comments])}',
            dataType: 'script',
            data: {contrinerId: '#{comments_container_id}'},
            type: 'GET'
          });
        </script>
        EOF
      else
        render :partial => "discussion/comments/list_with_form", locals: {commentable: commentable}
      end
    end
  end
end