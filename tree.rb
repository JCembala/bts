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

  # Return nil or node if it exists in tree
  def find(node_data, root = @root)
    return nil if root.nil?
    return root if root.data == node_data

    node_data < root.data ? find(node_data, root.left) : find(node_data, root.right)
  end

  def level_order(arr = Array.new(1, @root), backup_items = [], &block)
    return backup_items if arr.empty?

    current_node = arr.shift
    backup_items << current_node.data
    block.call current_node if block_given?
    arr << current_node.left unless current_node.left.nil?
    arr << current_node.right unless current_node.right.nil?
    level_order(arr, backup_items, &block)
  end

  # traverse tree in depth-first order
  # LEFT ROOT RIGHT
  def inorder(node = @root, &block)
    return if node.nil?

    inorder(node.left, &block)
    block.call node
    inorder(node.right, &block)
  end

  # traverse tree in depth-first order
  # ROOT LEFT RIGHT
  def preorder(node = @root, &block)
    return if node.nil?

    block.call node
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  # traverse tree in depth-first order
  # LEFT RIGHT ROOT
  def postorder(node = @root, &block)
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    block.call node
  end

  # accepts a node and returns its height
  def height(node = @root)
    return 0 if node == @root
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  # accepts a node and returns its depth
  def depth(node, parent = @root, node_depth = 0)
    return 0 if node == @root

    if node < parent
      depth(node, parent.left, node_depth + 1)
    elsif node > parent
      depth(node, parent.right, node_depth + 1)
    else
      node_depth
    end
  end

  # checks if the tree is balanced
  def balanced?; end

  # rebalances an unbalanced tree
  def rebalance; end

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
