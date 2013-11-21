load "harmony.rb"

include Harmony
#file = File.open(ARGV[0], "r").read.split(/\n/)

class Tune
  attr_accessor :chart, :irb

  def initialize(file = "allthethingsyouare.jazz")
    @irb = File.open(file, "r").read.split(/\n/)
    @chords = @irb.delete_if {|line| line[0] == "*" || line[0] == "!" || line.length < 3}
  
    @chords.map! {|chord| chord.gsub(/:/,"")}
    @chords.map! {|chord| chord.gsub(/\./,"")}
    @chords.map! {|chord| chord.gsub(/b9/,"")}
    @chords.map! {|chord| chord.gsub(/#9/,"")}
    @chords.map! {|chord| chord.gsub(/b13/,"")}
    @chords.map! {|chord| chord.gsub(/#11/,"")}
    @chords.map! {|chord| chord.gsub(/u/,"")}
    @chords.map! {|chord| chord.gsub(/\/.*/,"")}
    @chords.map! {|chord| chord.gsub(/\(.*/,"")}

    @chords.map! {|chord| chord.gsub(/-/,"b")}
    @chords.map! {|chord| chord.gsub(/o/,"dim")}
    @chords.map! {|chord| chord.gsub(/min/,"m")}
    @chords.map! {|chord| chord.gsub(/maj/,"M")}
    @chords.map! {|chord| chord.gsub(/h7/,"m7b5")}
    @chords.map! {|chord| chord.gsub(/alt/,"#5")}
    @chords.map! {|chord| chord.gsub(/11/,"7")}

    @structure = [] 
    @durations = []
    @roots = []
    @quals = []

    @chords.each do |duration|
      @durations << duration.slice!(0)
    end

    @chords.each do |chord|
      if chord[1] == "#" || chord[1] == "b"
        @roots << chord.slice!(0..1)  
      else
        @roots << chord.slice!(0)
      end
    end
    
    @chart = @roots.zip @chords
    @chart.each do |chord|
      chord.push(@durations.shift)
    end
  end
end


x = Tune.new

x.chart.each do |root, qual|
 puts root + qual
 p chord(root, qual)
 gets
end

  
