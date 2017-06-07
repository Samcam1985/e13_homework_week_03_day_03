require "pry-byebug"
require_relative "artist"
require_relative "album"

Album.delete_all()
Artist.delete_all()
##

artist1 = Artist.new({ "name" => "Muse"})
artist2 = Artist.new({ "name" => "Posion"})

artist1.save()
artist2.save()

album1 = Album.new({ "title" => "Black Holes and Revelations", "artist_id" => artist1.id, "genre" => "Alternative rock" })
album2 = Album.new({ "title" => "Flesh & Blood", "artist_id" => artist2.id, "genre" => "Rock"   })
album3 = Album.new({ "title" => "Origin of Symmetry", "artist_id" => artist1.id, "genre" => "Alternative rock"  })
album1.save()
album2.save()
album3.save()


binding.pry
nil
