#This module provides a library for representing valid harmonic structures spelled enharmonically correctly.
module Harmony
  #defines hash keys 
  tones = [   :root, 
              :flatninth, 
              :ninth, 
              :sharpninth, 
              :flatthird,
              :third,
              :fourth,
              :sharpfourth,
              :flatfifth,
              :fifth,
              :sharpfifth,
              :flatthirteenth,
              :thirteenth,
              :doubleflatseventh,
              :flatseventh,
              :seventh
              ]

  #explicitly defines notes at intervals for given root notes
  aflat = ["Ab","Bbb","Bb","B", "Cb","C","Db","D","Ebb","Eb","E","Fb","F","Gbb","Gb","G"] 
  a = ["A","Bb","B","B#","C","C#","D","D#","Eb","E","E#","F","F#","Gb","G","G#"]
  asharp = ["A#","B","B#","B##","C#","C##","D#","D##","E","E#","E##","F#","F##","G","G#","G##"]

  bflat = ["Bb","Cb","C","C#","Db","D","Eb","E","Fb","F","F#","Gb","G","Abb","Ab","A"]
  b = ["B","C","C#","C##","D","D#","E","E#","F","F#","F##","G","G#","Ab","A","A#"]
  #bsharp

  #cflat
  c = ["C","Db","D","D#","Eb","E","F","F#","Gb","G","G#","Ab","A","Bbb","Bb","B"]
  csharp = ["C#","D","D#","D##","E","E#","F#","F##","G","G#","G##","A","A#","Bb","B","B#"]

  dflat = ["Db","Ebb","Eb","E","Fb","F","Gb","G","Abb","Ab","A","Bbb","Bb","Cbb","Cb","C"]
  d = ["D","Eb","E","E#","F","F#","G","G#","Ab","A","A#","Bb","B","Cb","C","C#"]
  dsharp = ["D#","E","E#","E##","F#","F##","G#","G##","A","A#","A##","B","B#","C","C#","C##"]

  eflat = ["Eb","Fb","F","F#","Gb","G","Ab","A","Bbb","Bb","B","Cb","C","Dbb","Db","D"]
  e = ["E","F","F#","F##","G","G#","A","A#","Bb","B","B#","C","C#","Db","D","D#"]
  #esharp

  #fflat
  f = ["F","Gb","G","G#","Ab","A","Bb","B","Cb","C","C#","Db","D","Ebb","Eb","E"]
  fsharp = ["F#","G","G#","G##","A","A#","B","B#","C","C#","C##","D","D#","Eb","E","E#"]

  gflat = ["Gb","Abb","Ab","A","Bbb","Bb","Cb","C","Dbb","Db","D","Ebb","Eb","Fbb","Fb","F"]
  g = ["G","Ab","A","A#","Bb","B","C","C#","Db","D","D#","Eb","E","Fb","F","F#"]
  gsharp =["G#","A","A#","A##","B","B#","C#","C##","D","D#","D##","E","E#","F","F#","F##"]


  #Zips scale degree names as keys to note arrays
  aflattones = Hash[tones.zip aflat]
  atones = Hash[tones.zip a]
  asharptones = Hash[tones.zip asharp]

  bflattones = Hash[tones.zip bflat]
  btones = Hash[tones.zip b]

  ctones = Hash[tones.zip c]
  csharptones = Hash[tones.zip csharp]

  dflattones = Hash[tones.zip dflat]
  dtones = Hash[tones.zip d]
  dsharptones = Hash[tones.zip dsharp]

  eflattones = Hash[tones.zip eflat]
  etones = Hash[tones.zip e]

  ftones = Hash[tones.zip f]
  fsharptones = Hash[tones.zip fsharp]

  gflattones = Hash[tones.zip gflat]
  gtones = Hash[tones.zip g]
  gsharptones = Hash[tones.zip gsharp]


  #collects note hashes in a master hash ; keys are a given root
  @@lookup = {    "Ab" => aflattones, 
                  "A" => atones, 
                  "A#" => asharptones, 
                  "Bb" => bflattones, 
                  "B" => btones,
                  "C" => ctones, 
                  "C#" => csharptones,
                  "Db" => dflattones, 
                  "D" => dtones,
                  "D#" => dsharptones,
                  "Eb" => eflattones, 
                  "E" => etones, 
                  "F" => ftones, 
                  "F#" => fsharptones, 
                  "Gb" => gflattones,
                  "G" => gtones,
                  "G#" => gsharptones
                  }


#i should probably decouple this as a function and instead have a different file to model chords/scales/tunes etc as objects. 
  def chord(root = "C", qual = "M", inv = 0)
    qual = "M" if qual == ""

    lib = @@lookup[root.capitalize]

    return [lib[:root], lib[:third], lib[:fifth]] if qual == "M"
    return [lib[:root], lib[:flatthird], lib[:fifth]] if qual == "m"
    return [lib[:root], lib[:flatthird], lib[:flatfifth]] if qual == "dim"
    return [lib[:root], lib[:third], lib[:sharpfifth]] if qual == "+"

                          
    return [lib[:root], lib[:third], lib[:fifth], lib[:thirteenth]] if qual == "6"
    return [lib[:root], lib[:third], lib[:fifth], lib[:seventh]] if qual == "M7"
    return [lib[:root], lib[:flatthird], lib[:fifth], lib[:flatseventh]] if qual == "m7"
    return [lib[:root], lib[:flatthird], lib[:fifth], lib[:thirteenth]] if qual == "m6"
    return [lib[:root], lib[:third], lib[:fifth], lib[:flatseventh]] if qual == "7"
    return [lib[:root], lib[:flatthird], lib[:flatfifth], lib[:flatseventh]] if qual == "m7b5"
    return [lib[:root], lib[:flatthird], lib[:flatfifth], lib[:doubleflatseventh]] if qual == "dim7"
    return [lib[:root], lib[:flatthird], lib[:fifth], lib[:seventh]] if qual == "mM7"
    return [lib[:root], lib[:third], lib[:sharpfifth], lib[:seventh]] if qual == "M7#5"
    return [lib[:root], lib[:third], lib[:sharpfifth], lib[:flatseventh]] if qual == "7#5"
  end

  def voice(irb)
    file = File.open(irb, "r").read.split(/\n/)
    file.delete_if {|line| line[0] == "*" || line[0] == "!"}
    file.delete_if {|line| line.length < 3}
  end

  def scale(root = "C", scale = "Major")
    lib = @@lookup[root.capitalize]

    case scale
      when "Major"
        [lib[:root],lib[:ninth],lib[:third],lib[:fourth],lib[:fifth],lib[:thirteenth],lib[:seventh]]
      when "Melodic Minor"
        [lib[:root],lib[:ninth],lib[:flatthird],lib[:fourth],lib[:fifth],lib[:thirteenth],lib[:seventh]]
      when "Harmonic Minor"
        [lib[:root],lib[:ninth],lib[:flatthird],lib[:fourth],lib[:fifth],lib[:flatthirteenth],lib[:seventh]]
      when "Harmonic Major"
        [lib[:root],lib[:ninth],lib[:third],lib[:fourth],lib[:fifth],lib[:flatthirteenth],lib[:seventh]]
    end
  end
end



