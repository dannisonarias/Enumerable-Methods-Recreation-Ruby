# rubocop:disable Layout/LineLength

require './main'
RSpec.describe Enumerable do
  let(:array1) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
  let(:array_strings) { %w[cat dog monkey lion elephant] }
  let(:array_mix) { [1, 'b', 3.14, 4] }
  let(:array5) { [1, 5, 3, 4] }

  describe 'test my each method with different inputs' do
    it 'test my each method with no block given, tests same array outputs - converts output to array' do
      expect(array_strings.my_each.to_a).to eql(array_strings.each.to_a)
    end

    it 'test my each method with no block given, tests same class enumerator' do
      expect(array_strings.my_each.class).to eql(array_strings.each.class)
    end
  end

  describe 'test my_each_with_index method with different inputs' do
    it 'test my_each_with_index ckeck on index values within an array' do
      count = 0
      array1.my_each_with_index do |_a, x|
        expect(count).to eql(x)
        count += 1
      end
    end
    it 'test my_each_with_index method with no block given, same array - converts output to array' do
      expect(array_strings.my_each_with_index.to_a).to eql(array_strings.each_with_index.to_a)
    end

    it 'test my_each_with_index method with no block given, same class enumerator' do
      expect(array_strings.my_each_with_index.class).to eql(array_strings.each.class)
    end
  end

  describe 'test my_select method with different inputs' do
    it 'test my_selec to select even numbers after operation is applied (x+1)' do
      expect(array1.my_select { |x| (x + 1).even? }).to eql(array1.select { |x| (x + 1).even? })
    end
    it 'test my_selec returns a Enumerable when no block given' do
      expect(array1.my_select.class).to eql(array1.select.class)
    end
  end

  describe 'test my_all method with different inputs' do
    it 'test my_all to check for elements with length >=3' do
      expect(array_strings.my_all? { |word| word.length >= 3 }).to eql(array_strings.my_all? { |word| word.length >= 3 })
    end
    it "test my_all to look for a special regexp character 'a'" do
      expect(array_strings.my_all?(/a/)).to eql(array_strings.my_all?(/a/))
    end
    it "test my_all to match a 'Numeric' data type " do
      expect(array_mix.my_all?(Numeric)).to eql(array_mix.my_all?(Numeric))
    end
  end

  describe 'test my_any? method with different inputs' do
    it 'test my_any? to check for elements with length >=3' do
      expect(array_strings.my_any? { |word| word.length >= 3 }).to eql(array_strings.any? { |word| word.length >= 3 })
    end
    it "test ? to look for a special regexp character 'a'" do
      expect(array_strings.my_any?(/a/)).to eql(array_strings.any?(/a/))
    end
    it "test my_any? to match a 'Numeric' data type " do
      expect(array_mix.my_any?(Numeric)).to eql(array_mix.any?(Numeric))
    end
  end

  describe 'test my_none? method with different inputs' do
    it 'test my_none? to check for elements with length >=3' do
      expect(array_strings.my_none? { |word| word.length >= 3 }).to eql(array_strings.none? { |word| word.length >= 3 })
    end
    it "test my_none? to look for a special regexp character 'a'" do
      expect(array_strings.my_none?(/a/)).to eql(array_strings.none?(/a/))
    end
    it "test my_none? to match a 'Numeric' data type " do
      expect(array_mix.my_none?(Numeric)).to eql(array_mix.none?(Numeric))
    end
  end

  describe 'test my_count method with different inputs' do
    it 'test my_count to check for elements with length >=3' do
      expect(array_strings.my_count { |word| word.length >= 3 }).to eql(array_strings.count { |word| word.length >= 3 })
    end
    it "test my_count? to look for a special regexp character 'a'" do
      expect(array_strings.my_count(/a/)).to eql(array_strings.count(/a/))
    end
    it "test my_count to match a 'Numeric' data type " do
      expect(array_mix.my_count(Numeric)).to eql(array_mix.count(Numeric))
    end
  end

  describe 'test my_map method with different inputs including procs' do
    it 'test my_map to check for elements with length >=3' do
      expect(array_strings.my_map { |word| word.length >= 3 }).to eql(array_strings.map { |word| word.length >= 3 })
    end
    it "test my_map to look for a special regexp character 'a'" do
      expect(array_strings.my_map { |i| i.match(/[a-z]/) }).to eql(array_strings.map { |i| i.match(/[a-z]/) })
    end
    it "test my_map to match a 'Numeric' data type " do
      expect(array_mix.my_map { |i| i.is_a? Numeric }).to eql(array_mix.map { |i| i.is_a? Numeric })
    end
    it 'testing my map to accept a proc' do
      proc1 = proc { |x| x / 2.0 > 3.0 }
      expect(array1.my_map(&proc1)).to eql(array1.map(&proc1))
    end
  end

  describe 'test my_inject method with different inputs' do
    it 'return the string with the longest .length' do
      expect(array_strings.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql(array_strings.inject { |memo, word| memo.length > word.length ? memo : word })
    end

    it "test my_inject to match a 'Numeric' data type and accumulate sum " do
      expect(array5.my_inject { |total, i| total + i }).to eql(13)
    end

    it 'test my_inject to work with a numeric operation using symbol parameter :+ ' do
      expect(array5.my_inject(:+)).to eql(array5.inject(:+))
    end

    it 'test my_inject to work with a numeric operation using symbol parameter :+, and an initial memo value ' do
      expect(array5.my_inject(5, :+)).to eql(array5.inject(5, :+))
    end
  end
end

# rubocop:enable Layout/LineLength
