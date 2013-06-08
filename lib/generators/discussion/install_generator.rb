module Discussion
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc %q{
            Description:
                Installs migration files
                Mount discussion in the routes
                Generates the initialization file
            }

      def install
        rake("discussion:install:migrations")
        route "mount Discussion::Engine => '/discussion', as: 'discussion'"
        copy_file "discussion.rb.erb", "config/initializers/discussion.rb"
      end
    end
  end
end