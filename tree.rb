# frozen_string_literal: true

require_relative 'node'

# Tree class allows to build BTS based on array which initializes class
class Tree

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree
  end

  # Prints tree connected with some pipes
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  # Builds tree based on array which class was initialized with
  def build_tree(arr = @array)
    return nil if arr.empty?

    mid = (arr.size - 1) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..-1])
    root
  end
end
