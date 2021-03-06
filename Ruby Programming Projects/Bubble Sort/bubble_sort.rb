#Bubble sort without yield
def bubble_sort array
  loop do
    sorted = true
    (0...array.length-1).each do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        sorted = false
      end
    end
    break if sorted
  end
  array
end
array = [4,3,78,2,0,2]
bubble_sort array

#Bubble sort using yield
def bubble_sort_by array
  loop do
    sorted = true
      (0...array.length-1).each do |i|
        if yield(array[i], array[i+1]) < 0
          array[i], array[i+1] = array[i+1], array[i]
          sorted = false
        end
      end
    break if sorted
  end
  array
end
bubble_sort_by(["hi","hello","hey"]) do |left,right|
  right.length - left.length
end
