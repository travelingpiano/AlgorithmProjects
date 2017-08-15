class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_num = 0
    self.flatten.each_with_index{|num, idx| hash_num += num*idx}
    hash_num.hash
  end
end

class String
  def hash
    alphabets = ("a".."z").to_a
    hash_num = 0
    self.chars.each_with_index{|letter, idx| hash_num += alphabets.find_index(letter.downcase)*idx}
    hash_num.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_num = 0
    self.keys.each{|key| hash_num += key.to_s.hash*self[key].hash}
    hash_num
  end
end
