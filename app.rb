require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'erb'

class User < ActiveRecord::Base
end

get '/' do
	erb :index
end

get '/signup' do
	erb :signup
end

post '/signup' do
	@user = User.new(params)
	if @user.save
		redirect "/#{@user.id}"
	else
		'Something went wrong!!!'
	end
end

get '/:id' do
	@user = User.find(params[:id])
	erb :view
end