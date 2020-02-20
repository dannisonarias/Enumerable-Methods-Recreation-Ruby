# frozen_string_literal: true
# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength:

module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    for i in 0...self.length
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    for i in 0...self.length
      yield(i, self[i])
    end
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_all
    return to_enum :my_all unless block_given?

    test_all = true
    my_each { |i| test_all = false unless yield(i) }
    p test_all
  end

  def my_any?(param = nil)
    result = false
    if block_given? && param.nil?
      my_each { |i| return true if yield(i) }
    elsif val.is_a? Regexp
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

  def my_none?(_param = nil)
    result = true
    if block_given?
      my_each { |i| result = false if yield(i) }
    else
      result = false if my_any?
    end
  end

  def my_count(param = nil)
    count = 0
    unless param.nil?
      for num in 0..self.length
        count += 1 if self[num] == param
      end
    end
    if block_given?
      p my_each
      count += 1 if my_each{ |i| yield(i) } 
    elsif param.nil? 
      return self.length
    end
    p count
  end

  def my_map
    count = 0
    unless param.nil?
      for num in 0..self.length
        count += 1 if self[num] == param
      end
    end
    if block_given?
      p my_each
      count += 1 if my_each{ |i| yield(i) } 
    elsif param.nil? 
      return self.length
    end
    p count
  end


end

a = %w[ a b c d e f ]
p a.my_select {|v| v =~ /[aeiou]/ }
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength:
