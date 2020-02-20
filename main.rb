module Enumerable

    def my_each
      return to_enum :my_each unless block_given?
      for i in 0...self.length
        yield(self[i])
      end
      self
    end
    
end
