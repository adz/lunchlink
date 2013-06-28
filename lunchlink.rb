require 'sinatra'
require 'date'

require_relative 'models/schedule'

get '/' do
  @schedule = Schedule.new(Date.today)
  haml :'index.html'
end
