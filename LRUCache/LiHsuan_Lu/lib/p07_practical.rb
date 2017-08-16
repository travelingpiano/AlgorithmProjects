require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash_map = HashMap.new(26)

  string.chars.each do |letter|
    if !hash_map.include?(letter)
      hash_map.set(letter, 1)
    else
      #update frequency of letter
      hash_map.set(letter,hash_map[letter]+1)
    end
  end
  hash_map.select{|key, val| val%2 == 1}.length < 2
end
