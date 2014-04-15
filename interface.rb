require "sinatra"
require_relative "public/harmony"
include Harmony

get("/") do

  @chord = chord(params["root"], params["quality"]) if params != {}
  @params = params
  erb :index

end
