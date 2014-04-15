require "sinatra"
require_relative "public/harmony"
include Harmony

get("/") do

  @chord = chord(params["root"], params["quality"]) if params != {}
  @chord.map! {|n| n.downcase + "/4"}

  @accs = []
  @chord.each_with_index do |note, i|
    if note[1..-1].include? "#"
      @accs << ".addAccidental(#{i}, new Vex.Flow.Accidental(\"#\"))"
    end
    if note[1..-1].include? "b"
      @accs << ".addAccidental(#{i}, new Vex.Flow.Accidental(\"b\"))"
    end
  end

  @params = params
  erb :index

end
