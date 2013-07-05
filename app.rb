require 'sinatra'
require 'json'
require "sinatra/activerecord"
require './config/environments'
Dir.glob('./lib/*.rb') { |file| require file }


# set :database, "sqlite3:///rsvps.db"



class JeffAndClare < Sinatra::Base

  get '/' do

    @locations = Location.all

    @locations.each do |location|
      puts location
      # location.contentsategory = Category.find(location.category_id)
    end
    erb :show
  end


  post '/' do
    # TODO: Read the message contents, save to the database

  end

  get '/admin' do
    erb :rsvp
  end

  helpers do

    def link_to(url,text=url,opts={})
      attributes = ""
      opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
      "<a href=\"#{url}\" #{attributes}>#{text}</a>"
    end

  end

end
