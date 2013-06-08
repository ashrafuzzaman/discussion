Discussion By [Ashrafuzzaman](http://www.ashrafuzzaman.com).

Discussion is a thread discussion and comment solution. It:

* Is a rails mountable engine, so mount it to your app and run it
* Create discussion or comment on any model
* Add your own layout
* Built in ajaxified options
* Built in filter with [ransack](https://github.com/ernie/ransack) and pagination with [kaminari](https://github.com/amatsuda/kaminari)

## Getting started
Discussion works with Rails 3.2 onwards. You can add it to your Gemfile with:

```ruby
gem 'discussion'
```

Run the bundle command to install it.

```console
rails generate discussion:install
```

Add the following code to your ApplicationHelper. It will be needed as this gem uses the theme of the application.

```ruby
def method_missing(method, *args, &block)
  main_app.send(method, *args, &block)
rescue NoMethodError
  super
end
```

You can modify the route to change the mount position.

```ruby
mount Discussion::Engine => "/discussion", as: 'discussion'
```

## Configure

Configure the config/initializers/discussion.rb


## Customize views
You can generate views in to your app to customize it.

```console
rails generate discussion:views
```


## License
MIT License. Copyright 2009-2013 [Ashrafuzzaman](http://www.ashrafuzzaman.com).
You are not granted rights or licenses to the trademarks of the Discussion, including without limitation the Discussion name.