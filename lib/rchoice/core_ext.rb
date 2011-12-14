class Array
  def rand_el
    i = rand(length)
    self[i]
  end
end

class Object
  def blank?
    to_s.strip == ''
  end
  def present?
    !blank?
  end
end

class String
  def valid_number_format?
    return false if blank?
    return false unless self.strip =~ /^[0-9\.\-]+$/
    true
  end
  def safe_to_i
    raise "not valid number format #{self}" unless valid_number_format?
    to_i
  end
  def safe_to_f
    raise "not valid number format #{self}" unless valid_number_format?
    to_f
  end
end