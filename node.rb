# frozen_string_literal: true

# Single tree element
class Node
  include Comparable
  attr_accessor :data, :right, :left

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end

  def leaf?
    return true if @left.nil? && @right.nil?

    false
  end
end
