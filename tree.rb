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

  # Deletes a node with given value from tree
  def delete(node_data)
    parent = Node.new
    left = false
    wanted = @root

    while wanted.data != node_data
      parent = wanted
      if node_data < wanted.data
        wanted = wanted.left
        left = true
      else
        wanted = wanted.right
      end
    end

    case wanted.children
    when :leaf
      left ? parent.left = nil : parent.right = nil
    when :left
      parent.left = wanted.left
    when :right
      parent.right = wanted.right
    when :both
      right_subtree = wanted.right
      minimal_node = find_minimal_node right_subtree
      # deleting old node which was found minimal in right tree
      delete(minimal_node.data)
      # inserting minimal node in place of wanted node
      minimal_node.left = wanted.left
      left ? parent.left = minimal_node : parent.right = minimal_node
    end
  end

  # Inserts a node into tree
  def insert(node_data, root = @root, left_side: true)
    return root.left = Node.new(node_data) if root.left.nil? && left_side
    return root.right = Node.new(node_data) if root.right.nil? && !left_side

    node_data < root.data ? insert(node_data, root.left) : insert(node_data, root.right, left_side: false)
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

  def find_minimal_node(root)
    return root if root.left.nil?

    find_minimal_node(root.left)
  end
end
