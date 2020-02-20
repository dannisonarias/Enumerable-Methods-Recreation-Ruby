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

  def my_none?(_param = nil)
    result = true
    if block_given?
      my_each { |i| result = false if yield(i) }
    else
      result = false if my_any?
    end
    result
  end

  def my_count(param = nil)
    count = 0
    unless param.nil?
      for num in 0...self.length
        count += 1 if self[num] == param
        end
    end
    if block_given?
      for num in 0...self.length
        count += 1 if yield(self[num])
      end
    elsif param.nil?
      return self.length
    end
    count
  end

  def my_map(block = nil)
    result_array = []
    if block_given?
    my_each { |i| result_array.push(yield(i)) }
    result_array
    end
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

  #map
  p 'start map'
  p test_arr.map {|num| num * 10 }
  test_block = Proc.new {|elem| elem * 10}
  p test_arr.map(&test_block)
  p 'my map'
  p test_arr.my_map {|num| num * 10 }
  p test_arr.my_map(&test_block)
  
  #reduce
  p 'start reduce'
  p test_arr.reduce {|result,elem| result + elem}
  p 'myreduce'
  p test_arr.my_inject {|result,elem| result + elem}

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength:
