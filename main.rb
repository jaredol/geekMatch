require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'pg' # for postgresql database
require 'pry'

require_relative 'config'
require_relative 'profile'



after do
  ActiveRecord::Base.connection.close
end

#binding.pry

# Home page
get '/' do
  @profiles = Profile.all
  erb :index
end

# View results page
get '/results' do
  gender = params[:gender].capitalize
  age_from, age_to = params[:age].split('-') # "25-30" => ['25','30']
  @profiles = Profile.where("gender = ? AND age >= ? and age <= ?", gender, age_from.to_i, age_to.to_i)
  erb :results
end

# Create profile page

get '/profiles/new' do # show the form
  erb :create_profile
end

# View profile page

get '/profiles/:id' do
  @profile = Profile.find(params[:id])
  erb :profile_details
end


post '/profiles' do # actual create profile
  profile = Profile.new
  profile.fullname = params[:fullname]
  if profile.save == true
    # save returns true means success
    redirect to '/'
  else 
    erb :create_profile
  end
end






