require "sinatra/sequel"
require "sqlite3"

configure :development do
  set :database, "sqlite://tmp/development.sqlite"
end

configure :test do
  set :database, "sqlite3::memory:"
end

require_relative "migrations"

Sequel::Model.strict_param_setting = false
# Dir["models/**/*.rb"].each{|model|
#   require model
# }

require "trailblazer/operation"
require "reform/form/dry"
require "trailblazer/cells"
# require "cells-slim"
require "cells-hamlit"

Trailblazer::Cell.class_eval do
  # include Cell::Slim
  include Cell::Hamlit
  self.view_paths = ["concepts"] # DISCUSS: is that the right place?
end

# TODO: use trailblazer-loader.
require_relative "../concepts/post/operation/create.rb"
require_relative "../concepts/post/operation/update.rb"
require_relative "../concepts/post/cell/new.rb"
require_relative "../concepts/post/cell/show.rb"

require_relative "../gemgem/cell/layout.rb"
