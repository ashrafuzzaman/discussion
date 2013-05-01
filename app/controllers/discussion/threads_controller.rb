require_dependency "discussion/application_controller"

module Discussion
  class ThreadsController < InheritedResources::Base
    include InheritedResources::DSL
    actions :all, :except => [:edit]

    update! do |success, failure|
      success.html { redirect_to @thread }
    end
  end
end