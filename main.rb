# rubocop:disable Metrics/ModuleLength,Metrics/CyclomaticComplexity,Style/CaseEquality,Metrics/PerceivedComplexity,Lint/RedundantCopDisableDirective,Lint/Syntax

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
    a.length.times { |i| yield(a[i], i) }
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
    if !block_given? && param.nil?
      my_each { |i| test_all = false if [false, nil].include? i }
    elsif block_given? && param.nil?
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
    elsif !param.nil?
      my_each { |i| test_all = false unless i === param }
    end
    test_all
  end

  def my_any?(param = nil)
    result = false
    if block_given? && param.nil?
      my_each { |i| return true if yield(i) }
    elsif param.nil?
      my_each do |i|
        return true unless [false, nil].include? i
      end
    elsif param.is_a? Regexp
      my_each { |num| result = true if num =~ param }
    elsif param.is_a? Class
      my_each do |i|
        return true if i.is_a?(param)
      end
    elsif !param.nil?
      my_each { |i| return true if i == param }
    end
    result
  end

  def my_none?(param = nil)
    result = true
    result = false if my_any?(param)
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
    return to_enum :my_each_with_index unless block_given?

    result_array = []
    my_each { |i| result_array.push(yield(i)) }
    result_array
  end

  def my_inject(init = nil, sym = nil)
    a = self
    a = *self if is_a? Range
    if init.is_a? Symbol
      total = first
      a.shift
      sym = init
      a.each { |k| total = total.send(sym, k) }
      total
    elsif sym.is_a? Symbol
      total = init
      a.each { |k| total = total.send(sym, k) }
      total
    elsif (init.is_a? Numeric) && block_given?
      total = init
      a.each { |k| total += k }
      total
    end
    if block_given?
      total = first
      a.shift
      a.each { |k| total = yield(total, k) }
      total
    end
    total
  end

  def multiply_els
    my_inject { |total, value| total * value }
  end
end
# rubocop:enable Metrics/ModuleLength,Metrics/CyclomaticComplexity,Style/CaseEquality,Metrics/PerceivedComplexity,Lint/RedundantCopDisableDirective,Lint/Syntax
