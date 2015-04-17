require 'sinatra'
require 'httparty'
require 'pg' # for postgresql database
require 'bcrypt'

require_relative 'config'
require_relative 'profile'

enable :sessions


# database config
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'geek_match'
  ) 

ActiveRecord::Base.logger = Logger.new (STDERR)   # show

# convention: look for a table named properties (we are creating a class to map to table) 
class Post < ActiveRecord::Base
    validates :title, :presence => true
    belongs_to :category #singular becasue belongs to means belongs to one
end

class User < ActiveRecord::Base
  has_secure_password
end

#binding.pry


after do
  ActiveRecord::Base.connection.close
end



#login
get '/session/new' do
    erb :login
end

post '/session' do
    @user = User.where(email: params[:email]).first

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #correct password
      redirect to '/'
    else
      #incorrect password
      erb :login
    end
end

delete '/session' do
  session[:user_id] = nil
  redirect to '/'
end

helpers do
  def logged_in?
    !!current_user
  end

  def current_user
    @user = User.find_by(id: session[:user_id])
  end
end

# end login code





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
  profile.full_name = params[:full_name]
  profile.username = params[:username]
  profile.email = params[:email]
  profile.age = params[:age]
  profile.gender = params[:gender]
  profile.profile_desc = params[:profile_desc]
  profile.image_url = params[:image_url]


  #populate the User table
  user = User.new
  

  if profile.save == true
    # save returns true means success
    redirect to '/'
  else 
    erb :create_profile
  end
end






