class Date

  def self.wday_regex
    /#{wday_regex_string}/i
  end

  def self.wday_regex_string
    @@wday_regex_string ||= "#{DAYNAMES.map { |dn| "(#{dn}(s?))" }.join('|')}"
  end

end
