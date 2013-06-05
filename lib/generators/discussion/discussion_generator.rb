class DiscussionGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../../../app/views/discussion', __FILE__)

  desc %q{
  Description:
      Copies Discussion view files to your application's /views/discussion directory.
  }

  def views
    files = [
        'threads/show.html.erb',
        'threads/_index.html.erb',
        'threads/_form.html.erb',
        'threads/_list.html.erb',
        'threads/_view.html.erb',

        'comments/_form.html.erb',
        'comments/_list_with_form.html.erb',
        'comments/_view.html.erb',
    ]

    files.each do |file|
      copy_file file, "app/views/discussion/#{file}"
    end
  end
end
