class Regexp

  def insertable
    to_s[1..-2].gsub('?i-mx:', '').gsub('?-mix:', '').gsub('?-mx:', '')
  end

  def self.from_string(string)
    /(\b?)#{string}(\b?)/i
  end

end
