#\ -o 0.0.0.0 -p 9292
require File.absolute_path('app.rb', File.dirname(__FILE__))
run SampleApp::App.new
