require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash_map = HashMap.new(26)
  count = 0

  string.chars.each do |letter|
    if !hash_map.include?(letter)
      count += 1
      hash_map.set(letter, letter)
    end
  end
  count-1 <= string.chars.length/2
end
