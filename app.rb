require 'sinatra'
require 'json'
require "sinatra/activerecord"


set :database, "sqlite3:///rsvps.db"


get '/' do
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