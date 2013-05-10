module Discussion
  module ThreadsHelper
    def link_to_threads(options={}, &block)
      options = {remote: Discussion.ajaxify}.merge(options)
      link_to options[:link_text] || 'Threads', path_to_threads(options), options, &block
    end

    def path_to_threads(options={})
      sent_item = options[:sent_item].nil? ? nil : (options[:sent_item] ? 'true' : 'false')
      parent? ? main_app.polymorphic_url([parent, :threads], sent_item: sent_item) : threads_path(sent_item: sent_item)
    end

    def link_to_thread(thread, options={}, &block)
      path = parent? ? main_app.polymorphic_url([parent, thread]) : thread_path(thread)
      options = {remote: Discussion.ajaxify}.merge(options)
      link_to options[:link_text] || 'Threads', path, options, &block
    end

    def link_to_destroy_thread(thread, options={}, &block)
      options = {method: :delete, data: {confirm: 'Are you sure?'}, link_text: 'Destroy'}
      link_to_thread(thread, options, &block)
    end

    def link_to_new_thread(options={}, &block)
      path = parent? ? main_app.polymorphic_url([:new, parent, :thread]) : new_thread_path
      options = {remote: Discussion.ajaxify}.merge(options)
      link_to options[:link_text] || 'New Thread', path, options, &block
    end

    def form_path
      parent? ? main_app.polymorphic_url([parent, :threads]) : threads_path
    end
  end
end