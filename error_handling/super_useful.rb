class CoffeeError < StandardError
end

# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue
    p "Enter digits only"
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  begin
    if FRUITS.include? maybe_fruit
      puts "OMG, thanks so much for the #{maybe_fruit}!"
    elsif maybe_fruit == "coffee"
      raise CoffeeError 
    else 
      raise StandardError 
    end 
  rescue CoffeeError => c
    puts "Thank you for the Coffee"
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue
    puts "I want Coffee"
    retry
  end
end  

class YearsError < StandardError
end

class NameLengthError < StandardError
end

class PastimeLengthError < StandardError
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    begin
      raise YearsError if yrs_known < 5
      raise NameLengthError if name.length < 1
      raise PastimeLengthError if fav_pastime.length < 1
    rescue YearsError
      raise "Besties know each other for more than 5 years"
    rescue NameLengthError
      raise "Names must be at least one character"
    rescue PastimeLengthError
      raise "Pastimes must be at least one character"
    ensure
      yrs_known = 5
    end
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


