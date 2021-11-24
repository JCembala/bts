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

  # returns symbol which name which child was found
  # :leaf - when no children
  # :right - when 1 child on right side is found
  # :left - when 1 child on left side is found
  # :both - when 2 children
  def children
    return :leaf if leaf?

    return :both unless @right.nil? || @left.nil?

    return :left unless @left.nil?

    :right
  end
end
