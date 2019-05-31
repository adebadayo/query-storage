require 'rails'

class QueryStorage::InstallGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../../templates', __FILE__)
  def create_controllers
    debugger
    template "query_storages_controller.rb",
    "app/controllers/query_storages_controller.rb"
  # @scope_prefix = scope.blank? ? '' : (scope.camelize + '::')
  # controllers = options[:controllers] || CONTROLLERS
  # controllers.each do |name|
   # end
  end
  # def create_migration
  #   generate 'scaffold', "#{class_name} title:string sql:text"
  # end
end
