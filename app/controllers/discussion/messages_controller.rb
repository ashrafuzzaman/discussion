require_dependency "discussion/application_controller"

module Discussion
  class MessagesController < InheritedResources::Base
    actions :all, :except => [ :edit, :update ]
  end
end