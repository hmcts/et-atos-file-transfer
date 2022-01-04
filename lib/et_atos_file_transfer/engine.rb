require 'dotenv/rails'
Dotenv::Railtie.load
module EtAtosFileTransfer
  class Engine < ::Rails::Engine
    isolate_namespace EtAtosFileTransfer
    config.generators.api_only = true
  end
end
