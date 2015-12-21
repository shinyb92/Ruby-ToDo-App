File.open('test_list.txt').each do |line| 
  puts line 
end 

File.open('test_list.txt', 'a') do |line| 
  line.puts "\r" + "air up bike tires" 
end 

