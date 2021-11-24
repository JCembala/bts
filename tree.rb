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
    wanted = @root

    while wanted.data != node_data
      parent = wanted
      wanted = wanted.left if node_data < wanted.data
      wanted = wanted.right if node_data > wanted.data
    end

    # First case when there is no child
    # 1. Delete node (remove connection from parent to child)
    return unless wanted.leaf?

    parent.left = nil if wanted.data < parent.data
    parent.right = nil if wanted.data > parent.data

    # Second case when there is one child
    # 1. Find node
    # 2. Change parent connection from node we are looking to it's child
    #
    # Third case when there is more than one child
    # 1. Search right subtree for next bigger value than removed
    # 2. Move found value in the place we are removing
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
end
