require 'sinatra'
require 'json'
require "sinatra/activerecord"
Dir.glob('./lib/*.rb') { |file| require file }


# set :database, "sqlite3:///rsvps.db"
db = URI.parse('postgres://jeff@localhost/jeff_and_clare_development')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)


class JeffAndClare < Sinatra::Base

  get '/' do
    erb :show
    @locations = Location.all

    @locations.each do |location|
      location.category = Category.find(location.category_id)
    end

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
