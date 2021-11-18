# frozen_string_literal: true

require_relative 'node'

# Tree class allows to build BTS based on array which initializes class
class Tree

  def initialize(array)
    @root = Node.new
    @array = array.uniq.sort
  end

  def build_tree
    @root = array_to_bts
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def array_to_bts(arr = @array, start = 0, stop = @array.length)
    return nil if start > stop

    mid = (start + stop) / 2
    root = Node.new(arr[mid])
    root.left = array_to_bts(arr, start, mid - 1)
    root.right = array_to_bts(arr, mid + 1, stop)
    root
  end
end
