require_relative 'member_repository'

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
