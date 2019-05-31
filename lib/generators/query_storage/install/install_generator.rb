require 'rails'

class QueryStorage::InstallGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../../templates', __FILE__)
  CONTROLLERS = %w(queries).freeze
  VIEWS = %w(index show edit new _form _list).freeze

  def add_routes
    devise_route = <<-EOF
    resources :#{class_name.underscore.pluralize} do
        member do
        get :download_csv
        get :download_tsv
      end
    end
    EOF
    route devise_route
  end

  def create_models
    generate 'model', "#{class_name} title:string sql:text"
  end

  def create_controllers
    CONTROLLERS.each do |name|
      template "controllers/#{name}_controller.rb",
      "app/controllers/#{name}_controller.rb"
    end
  end

  def create_views
    directory "views", "app/views/#{class_name.underscore.pluralize}"
  end
end
