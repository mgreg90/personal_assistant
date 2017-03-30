class BinDay < String

  BIN_DAY_REGEX = /\b[01]{7}\b/

  class InvalidBinDay < StandardError; end

  def initialize(string)
    raise InvalidBinDay unless self.class.valid?(string)
    super(string)
  end

  def self.valid?(string)
    !!string.match(BIN_DAY_REGEX)
  end

  def to_wdays
    chars.map.with_index do |bin, idx|
      Date::DAYNAMES[idx] if bin == '1'
    end.compact
  end

  def blank?
    self == Date::EMPTY_BIN_DAY
  end

end
