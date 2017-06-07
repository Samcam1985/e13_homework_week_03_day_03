require "pg"
require_relative "artist"
require_relative "sql_runner"

class Album

  attr_accessor :title
  attr_reader :id

  def initialize(options)
    @title = options["title"]
    @id = options["id"].to_i() if options["id"]
    @artist_id = options["artist_id"].to_i
    @genre = options["genre"]
  end

  def save()
    sql = "INSERT INTO albums ( title, artist_id, genre ) VALUES ( '#{@title}', #{@artist_id}, '#{@genre}' ) RETURNING id;"
    @id = SqlRunner.run(sql)[0]["id"].to_i()
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def Album.delete_all()
    sql = "DELETE FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    results = SqlRunner.run(sql)
    artist_data = results[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def update()
    sql = "UPDATE albums SET (
    title,
    artist_id,
    genre
    ) = (
    '#{@title}',
     #{@artist_id},
      '#{@genre}'
    ) WHERE is = #{@id}"
    SqlRunner.run(sql)
  end

end
