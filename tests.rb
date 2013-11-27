require_relative "public/harmony"
contents = []

Dir.foreach("public/irb/") do |filename| 
  contents << filename
end

contents.sort!
contents.shift
contents.shift

gets

titles = []

contents.each do |filename|
  x = File.open("public/irb/#{filename}").grep(/OTL/).to_s
  x.slice!(0..9)
  x.slice!(-4..-1)
  titles << x
end

p titles




  
