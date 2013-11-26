require "sinatra"
require_relative "public/harmony"

get("/") do
  erb :index
end
