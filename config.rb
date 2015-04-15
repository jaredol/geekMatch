require 'active_record'
require 'profile'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'geek_match'
  )