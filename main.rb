# frozen_string_literal: true

require_relative 'tree'

def print_in_all_modes(bst)
  puts "\e[42m Level order print: \e[0m"
  bst.level_order { |node| print "#{node.data} " }
  puts
  puts "\e[42m Preorder print: \e[0m"
  bst.preorder { |node| print "#{node.data} " }
  puts
  puts "\e[42m Postorder print: \e[0m"
  bst.postorder { |node| print "#{node.data} " }
  puts
  puts "\e[42m Inorder print: \e[0m"
  bst.inorder { |node| print "#{node.data} " }
  puts
  bst.pretty_print
  puts
end

bst = Tree.new(Array.new(15) { rand(10..100) })
puts "Tree balanced: #{bst.balanced?}"
print_in_all_modes bst
bst.insert(120)
bst.insert(125)
bst.insert(130)
bst.insert(140)
bst.insert(145)
bst.insert(150)
bst.insert(155)
bst.insert(160)
puts 'Inserted some values.'
puts "Tree balanced: #{bst.balanced?}"
bst.rebalance
puts 'Rebalancing in progress...'
puts "Tree balanced: #{bst.balanced?}"
print_in_all_modes bst
