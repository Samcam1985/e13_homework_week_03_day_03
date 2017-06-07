require "pg"
class Customer
  attr_reader :id, :name

  def initialize(options)
      @id = options["id"].to_i
  end



end
