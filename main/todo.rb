
#I extended the Array class here with a new method that 
#combines functionality of .delete(item ) and insert methods 
#that arrays already have, neatly packaged into one. 
class Array 
  def replace_with original_item, index, new_item 
    self.delete(original_item)
    self.insert(index, new_item) 
  end
end 
 


class List
  attr_accessor :description  
  def initialize (description)
    @all_tasks = [] 
  end
  
  def add_task (task)
    @all_tasks.push(task)
  end
  
  def tasks
    @all_tasks  
  end 
  
  
  def show_all_tasks 
    @all_tasks
  end
  
  def remove_task task_no
    @all_tasks.delete(@all_tasks[task_no]) 
  end 
  
  def delete_all
    @all_tasks.clear  
  end 
  
  #Having a hard time implementing this feature. 
  #The problem, even with my handmade method for arrays above
  #is that I want to write to the task and then add it back 
  # to the all_tasks array 
  #I'm getting an error, basically with the final saving method. 
  #Basically it's getting converted into a string for some reason 
  #and it doesn't have a method for description in the block. 
  #it's weird. 
  
  #UPDATE: So the feature is implemented. My problem was that I didn't create 
  # a task object, with a description. 
  #my new problem is that for some reason, when it adds 'Complete' 
  #it adds it to a new line. I'm not sure how to remove this new line. 
  # and just have it change the description 
  
  #Yet another update! So it looks like for some reason, using single quotes
  # and then adding to them, puts a newline. 
  #You also can't use newlines at all if there aren't "" double quotes
  #I fixed this accordingly, making the object take double quotes!
  def completed_task task_no 
   @complete = Task.new(" ")
   @complete.description = (@all_tasks[task_no].description + " --Complete!")
   @complete.description.sub!("\n", " ")
   @all_tasks.replace_with(@all_tasks[task_no], task_no, @complete)  
end

def save 
  list_file = File.open('todo_list.txt', 'w')
  @all_tasks.each do |task| 
    list_file.puts task.description
  end
end 

class Task 
  attr_accessor :description 
  def initialize (description)  
    @description = description  
  end
end 


my_list = List.new('another list')

puts 'Hi! Welcome to your friendly neighborhood Todo List.' 
puts 'Enter any blank text file name, and then start adding to the list.'
puts 'To get you started, enter "add task" and add a ToDo.' 
puts 'For a full list of commands type "commands".'  

puts 'Please enter a file name:' 

filename = gets.chomp
File.open(filename).each do |line| 
  my_list.add_task(Task.new(line))
end

running = true 

while running == true 

puts 'What would you like to do now?' 

request = gets.chomp.downcase 

case request 
when 'add task'
  puts 'What\'s the task?' 
  new_task = gets.chomp
  my_list.add_task(Task.new(new_task))
  my_list.save
when 'delete task'
  puts 'Which task would you like to delete? Enter it\'s number on the list:' 
  task_to_delete = (gets.chomp.to_i - 1) 
  my_list.remove_task(task_to_delete)
  my_list.save 
when 'task complete' 
  puts 'Which task is done? Enter it\'s number on the list:' 
  task_no= (gets.chomp.to_i - 1)
  my_list.completed_task(task_no)
  my_list.save 

  
when 'show tasks'
if my_list.tasks.empty? 
  puts 'There are no tasks yet! Add some to the list!' 
else 
  my_list.show_all_tasks.each_with_index do |task, index|
      puts (index + 1).to_s + '.' +  task.description 
  end
end 
when 'delete all' 
  puts 'Are you sure you want to delete all your current tasks?' 
  answer = gets.chomp 
    if answer == 'yes' 
      my_list.delete_all 
      puts 'All tasks were successfully deleted.'
    elsif answer == 'no' 
      puts 'No items were deleted! Whew!' 
    else 
      puts 'Please answer "yes" or "no".' 
    end 
when 'commands' 
  puts 'Your local Ruby todolist program accepts the following:' 
  puts " 'Add Task'     : Adds a task to the bottom of your list."
  puts " 'Delete Task'  : Deletes a task from your list. Specify list no."
  puts " 'Task Complete': Marks task as -- Complete!  " 
  puts " 'Show Tasks'   : Shows all of your current tasks. "
  puts " 'Delete all'   : Deletes ALL of your tasks. " 
  puts " 'Exit'         : Exits your current session. "  
when 'exit' 
  my_list.save 
  running = false 
else 
  puts 'I couldn\'t understand you. If you\'re trying to exit, type exit!'
  puts 'If you need a list of commands, type "commands".'
end 




end 

end
 



