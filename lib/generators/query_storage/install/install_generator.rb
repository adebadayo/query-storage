require 'rails'

class QueryStorage::InstallGenerator < Rails::Generators::NamedBase
  def create_migration
    generate 'model', "#{class_name} title:string sql:text"
  end
end
