require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash_map = HashMap.new(26)
  count = 0

  string.chars.each do |letter|
    if !hash_map.include?(letter)
      count += 1
      hash_map.set(letter, 1)
    else
      #update number of letters
      hash_map.set(letter,hash_map[letter]+1)
    end
  end
  odd = 0
  hash_map.each do |key,val|
    if val%2 == 1
      odd += 1
    end
    if odd == 2
      return false
    end
  end
  true
end
