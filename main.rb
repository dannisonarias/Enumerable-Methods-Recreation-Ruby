# frozen_string_literal: true
# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength:
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    length.times { |i| yield(self[i]) }
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    length.times { |i| yield(i, self[i]) }
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

    result = []
    my_each { |i| result.push(i) if yield(i) }
    result
  end

  def my_all?
    return to_enum :my_all? unless block_given?

    test_all = true
    my_each { |i| test_all = false unless yield(i) }
    test_all
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

  def my_none?(param = nil)
    result = true
    if block_given?
      my_each { |i| result = false if yield(i) }
    elsif param.is_a? Regexp
      my_each { |num| result = false if num =~ param }
    elsif param.is_a? Class
      my_each { |num| result = false if num.is_a? param }
    else
      result = false if my_any?
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
    unless init.nil?
      total = init
    end
    if sym.nil? && !block_given?
      each { |k| total += k }
    elsif sym.nil? && block_given?
      each { |k| total = yield(total, k) }
    end
    total
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength:
