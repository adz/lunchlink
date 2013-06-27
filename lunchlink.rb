require 'sinatra'
require 'date'

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

class Schedule
  DAYS_IN_A_WEEK = 7

  def initialize(date)
    @date = date
  end


  def next_person
    MemberRepository.fetch(index)
  end


  def current_person
    return "Nobody" unless is_today?

    current_index = index - 1
    if current_index < 0
      MemberRepository.last
    else
      MemberRepository.fetch(current_index)
    end
  end


  def index
    raw_index = (days_since_newest_member_cooked / DAYS_IN_A_WEEK) + 1 # round up after day-of-lunch as / rounds down
    raw_index % MemberRepository.count
  end


  def is_today?
    offset == 0
  end


  def offset
    days_since_newest_member_cooked % DAYS_IN_A_WEEK
  end


  def days_since_newest_member_cooked
    (@date - MemberRepository.date_newest_member_cooked).to_i
  end

end

get '/' do
  @schedule = Schedule.new(Date.today)
  haml :'index.html'
end
