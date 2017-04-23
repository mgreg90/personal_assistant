class String

  def number?
    to_i.to_s == self
  end

  def delete_and_return_idx!(substr)
    idx = index(substr)
    slice!(substr)
    idx
  end

end
