require 'sinatra'
require 'json'
require 'sinatra_warden'
require "sinatra/activerecord"
require './config/environments'
require 'rack-flash'
Dir.glob('./lib/*.rb') { |file| require file }


# set :database, "sqlite3:///rsvps.db"



class JeffAndClare < Sinatra::Base
  set :sessions => true
  use Rack::MethodOverride

  register do
    def auth (type)
      condition do
        redirect "/auth/login" unless send("is_#{type}?")
      end
    end
  end


  before do
    id = session[:user_id]
    @user = User.where(:id => id).first
  end

  # Admin auth routes

  get '/auth/login' do
    erb :login
  end

  post "/login" do
    session[:user_id] = User.authenticate(params).id
    if session[:user_id]
      redirect to "/protected"
    else
      redirect to "/"
    end
  end

  get "/logout" do
    session[:user_id] = nil
  end

  #Admin dashboard

  get "/protected", :auth => :user do
    "Hello, #{@user.user_name}."
    @locations = Location.all.sort_by(&:id)
    erb :admin, :layout => false
  end

  #Editing the locations

  put '/locations/:id' do
    @location = Location.find(params[:id])
    if @location.update(params[:location])
      status 201
      redirect '/locations/' + params[:id]
    else
      status 400
      erb :edit
    end
  end

  get '/locations/:id' do
    @location = Location.find(params[:id])
    erb :edit
  end

  post '/locations' do
    Location.create(params[:location])
  end

  # Main App routes

  get '/' do

    @locations = Location.all
    @categories = Category.all

    @categories.each do |category|
      @locations.each do |location|
        category.locations << location if category.id == location.category_id
      end
    end

    erb :show
  end


  post '/' do
    # TODO: Read the message contents, save to the database

  end







  helpers do

    def link_to(url,text=url,opts={})
      attributes = ""
      opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
      "<a href=\"#{url}\" #{attributes}>#{text}</a>"
    end

    def is_user?
      @user != nil
    end

  end

end
