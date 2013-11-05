require 'rubygems'
require 'bundler'

# Bundler.require
require 'sinatra'
require 'json'
require 'omniauth'
require 'omniauth-instagram'
require 'sinatra_warden'
require "sinatra/activerecord"
require './config/environments'
require 'rack-flash'
require 'figaro'

Dir.glob('./lib/*.rb') { |file| require file }



class JeffAndClare < Sinatra::Base
  set :sessions => true
  use Rack::MethodOverride
  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
  end

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
    puts Figaro.env.hello

    @locations = Location.all
    @categories = Category.all

    @categories.each do |category|
      @locations.each do |location|
        category.locations << location if category.id == location.category_id
      end
    end

    erb :show
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

module Figaro
  def path
    @path ||= File.join(JeffAndClare.settings.root, "config", "application.yml")
  end

  def environment
    JeffAndClare.settings.environment
  end
end

Figaro.env.each do |key, value|
  ENV[key] = value unless ENV.key?(key)
end
