class Regexp
  def insertable
    to_s[1..-2].gsub('?i-mx:', '').gsub('?-mix:', '').gsub('?-mx:', '')
  end
end
