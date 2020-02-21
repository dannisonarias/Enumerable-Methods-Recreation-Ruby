# frozen_string_literal: true

# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength:
# rubocop:disable Metrics/AbcSize

# This module is a creation of the original Enumerable
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    a = self
    a = *self if is_a? Range
    a.length.times { |i| yield(a[i]) }
    a
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    a = self
    a = *self if is_a? Range
    a.length.times { |i| yield(i, a[i]) }
    a
  end

  def my_select
    return to_enum :my_select unless block_given?

    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_all?(param = nil)
    test_all = true
    if block_given? && param.nil?
      my_each { |i| test_all = false unless yield(i) }
    elsif param.is_a? Regexp
      my_each { |i| test_all = false unless i =~ param }
    elsif param.nil?
      my_each do |i|
        test_all = false unless i == true
      end
    elsif param.is_a? Class
      my_each do |i|
        test_all = false unless i.is_a?(param)
      end
      test_all
    end
    test_all
  end

  def my_any?(param = nil)
    result = false
    if block_given? && param.nil?
      my_each { |i| return true if yield(i) }
    elsif param.is_a? Regexp
      my_each { |num| result = true if num =~ param }
    elsif param.nil?
      my_each do |i|
        return true if i == true
      end
    elsif param.is_a? Class
      my_each do |i|
        return true if i.is_a?(param)
      end
    end
    result
  end

  def my_none?(param = nil)
    result = true
    result = false if my_any?
    if block_given?
      my_each { |i| result = false if yield(i) }
    elsif param.is_a? Regexp
      my_each { |num| result = false if num =~ param }
    elsif param.is_a? Class
      my_each { |num| result = false if num.is_a? param }
    end
    result
  end

  def my_count(param = nil)
    count = 0
    unless param.nil?
      length.times { |num| count += 1 if self[num] == param }
    end
    if block_given?
      length.times { |num| count += 1 if yield(self[num]) }
    elsif param.nil?
      return length
    end
    count
  end

  def my_map
    result_array = []
    my_each { |i| result_array.push(yield(i)) }
    result_array
  end

  def my_inject(init = nil, sym = nil)
    total = 0
    total = self[0] if init.nil?
    shift if init.nil?
    total = init unless init.nil?
    if sym.nil? && !block_given?
      each { |k| total += k }
    elsif sym.nil? && block_given?
      each { |k| total = yield(total, k) }
    end
    total
  end

  def multiply_els
    my_inject { |total, value| total * value }
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength:
