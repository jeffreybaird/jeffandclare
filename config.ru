# config.ru

require './app'
require 'sass/plugin/rack'


$stdout.sync = true

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Sinatra::Application
