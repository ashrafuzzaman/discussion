module ApplicationHelper
  #to fix any call from the engine
  def method_missing(method, *args, &block)
    main_app.send(method, *args, &block)
  rescue NoMethodError
    super
  end
end