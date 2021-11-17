# frozen_string_literal: true

require_relative 'tree_node'

# Tree class allows to build BTS based on array which initializes class
class Tree

  def initialize(array)
    @root = TreeNode.new
    @array = array
  end

  # Builds the tree based on given array in #initialize
  def build_tree
    @root = @array[0]
  end
end
