class MemberRepository
  MEMBERS = %w(Noack Simon Jordan Kerri Adam Ty Smirnoff Jack)

  def self.fetch(id)
    MEMBERS[id]
  end

  def self.last
    MEMBERS[MEMBERS.size - 1]
  end

  def self.count
    MEMBERS.size
  end

  # Last remembered lunch link
  # - have to reset on new member add -- otherwise maths is wrong in calculating offsets
  def self.date_newest_member_cooked
    Date.new(2013, 05, 23) 
  end
end
