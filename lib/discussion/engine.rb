module Discussion
  class Engine < ::Rails::Engine
    isolate_namespace Discussion

    config.after_initialize do
      ActionView::Base.send(:include, Discussion::CommentsHelper)
    end
  end
end