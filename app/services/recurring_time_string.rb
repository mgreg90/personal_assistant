class RecurringTimeString < TimeString

  DEFAULT_INTERVAL = 1

  def initialize(string)
    super(string)
  end

  def interval
    # byebug if self == "every 26 weeks"
    10.times do |x|
      if values.respond_to?(:keys)
        return values[:interval]
      elsif values.respond_to?(:first) && [Integer, Fixnum, Bignum].include?(values.first.class)
        return values.first
      end
      return DEFAULT_INTERVAL
    end
    raise "Too Deeply Nested!"
  end

end
