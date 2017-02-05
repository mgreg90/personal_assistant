class Regexp

  def insertable
    to_s[1..-2].gsub('?i-mx:', '').gsub('?-mix:', '').gsub('?-mx:', '')
  end

  def self.from_string(string)
    /(\s?)#{string}(\s?)/i
  end

end
