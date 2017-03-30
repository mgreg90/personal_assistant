class Date

  EMPTY_BIN_DAY = '0000000'.freeze # Ordered sunday thru saturday
  EVERYDAY_BIN_DAY = '1111111'.freeze # Ordered sunday thru saturday
  WEEKDAYS_BIN_DAY = '1111111'.freeze # Ordered sunday thru saturday

  def self.wday_regex
    /#{wday_regex_string}/i
  end

  def self.wday_regex_string
    @@wday_regex_string ||= "#{DAYNAMES.map { |dn| "(#{dn}(s?))" }.join('|')}"
  end

  def bin_day
    @bin_day ||= begin
      bd = EMPTY_BIN_DAY.dup
      bd[wday] = '1'
      defined?(BinDay) ? BinDay.new(bd) : bd
    end
  end

end
