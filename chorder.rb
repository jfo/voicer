load "voicer.rb"
include Chord
#file = File.open(ARGV[0], "r").read.split(/\n/)


class Tune
  attr_accessor :chords, :structure, :durations, :everything, :roots

  def initialize(file = "allthethingsyouare.jazz")
    file = File.open(file, "r").read.split(/\n/)
    @chords = file.delete_if {|line| line[0] == "*" || line[0] == "!" || line.length < 3}
  
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
    
    @everything = @roots.zip @chords
   
  end
end

system("clear")
 x = Tune.new
 x.structure

 x.everything.each do |root, qual|
     p scale(root, "Melodic Minor")
 end
