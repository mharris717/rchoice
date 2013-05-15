require 'redis'

redis = Redis.new(:host => "spadefish.redistogo.com", :port => 9897, :password => "511c6d49855d3551c335781860c06cb3")
k = File.read("vol/choice.txt").strip
redis.set k,0