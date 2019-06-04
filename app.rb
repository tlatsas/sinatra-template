require 'bundler'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'tilt/erb'
require 'json'
require 'active_support/core_ext/hash/indifferent_access.rb'
require 'active_support/core_ext/object/blank.rb'
require 'better_errors'
require 'rest-client'

require_relative 'lib/helpers.rb'

module SampleApp
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)
    set :views, settings.root + '/views'

    configure :development do
      enable :logging
      register Sinatra::Reloader
      use BetterErrors::Middleware
      BetterErrors.application_root = __dir__
    end

    helpers SampleApp::Helpers

    get '/' do
      @data = {}

      request.accept.each do |type|
        case type.to_s
          when 'text/html'
            halt erb :index
          when 'application/json'
            halt json(@data, :encoder => :to_json, :content_type => :js)
          when 'text/json'
            halt json(@data, :encoder => :to_json, :content_type => :js)
        end
      end
    end
  end
end
