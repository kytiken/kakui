class Group
  attr_accessor :members
  attr_reader  :name, :identifier

  def initialize name
    @name = name
    @identifier = "@" + name
    @members = []
  end

  def join member
    @members << member
  end
  
  def delete member
    @members.delete(member)
  end
end
