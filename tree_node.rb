# frozen_string_literal: true

# Single tree element
class TreeNode
  include Comparable
  attr_reader :data, :right_children, :left_children

  def initialize(data = nil, left_children = nil, right_children = nil)
    @data = data
    @left_children = left_children
    @right_children = right_children
  end

  def <=>(other)
    data <=> other.data
  end
end
