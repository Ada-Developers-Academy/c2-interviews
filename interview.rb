class Interview
  require 'csv'
  attr_reader :company, :time_slot, :student_id, :room

  def initialize(company, student_id, room, day, time)
    @company    = company
    @student_id = student_id
    @room       = room
    @time_slot  = time_slot(day, time)
  end

  def self.all
    interviews = []
    CSV.foreach("interviews.csv", headers: true) do |row|
      int = Interview.new(
        row["company"],
        row["student_id"],
        row["room"],
        row["day"],
        row["time"]
      )
      interviews << int
    end
    interviews
  end

  def self.find_all_by(col, val)
    array = []
    self.all.each do |int|
      if int.send(col).to_s.downcase == val.to_s.downcase
        array << int
      end
    end
    array
  end

  def time_slot(day, time)
    time.insert(0, "0") if time.length == 4
    DateTime.strptime("#{day} #{time}", "%m/%d/%y %I:%M")
  end
end

Interview.parse_csv
