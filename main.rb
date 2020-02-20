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
        yield(i,self[i])
      end
      self
    end
    
    def my_select
      return to_enum :my_select unless block_given?
      result = []
      self.my_each{|i| result.push(i) if yield(i)}
      result
    end
    
end
