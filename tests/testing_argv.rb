first_arg, *the_rest = ARGV

puts first_arg 

puts the_rest.inspect 

command, *task_description = ARGV 

case command 
when 'add' 
  task_string = task_description.join(' ')
  task_obj = Task.new(task_string)
  first_list.add_task(task_obj) 
when 'complete' 
  puts 'Cool. Noted. Write more accurate code here.' 
when 'print' 
  first_list.show_all_tasks.each do |task| 
    puts task.description 
 end 
end  