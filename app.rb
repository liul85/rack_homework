require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'erb'

class User < ActiveRecord::Base
	def self.authenticate(username, password)
		user = User.find_by(username: username)
		if user && user.password == password
			user
		else
			nil
		end
	end
end

get '/' do
	erb :index
end

get '/login' do
	erb :login
end

post '/login' do
	user = User.authenticate(params[:username], params[:password])
	if user
		redirect "/#{user.id}"
	else
		"Wrong username and password combination!"
	end
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
