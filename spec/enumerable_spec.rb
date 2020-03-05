require "./main"
RSpec.describe Enumerable do
    let(:array1) {[1,2,3,4,5,6,7,8,9,10]}
    let(:array_strings) {%w[cat dog monkey lion elephant]}

    describe "test my each method with different inputs" do
        it "test my_each method with array of integers" do
            expect(array1.my_each{|i| p i+1 }).to eql(array1.each{|i| p i+1 })
        end

        it "test my each method with array of strings" do
            expect(array_strings.my_each{|i| p i+'1' }).to eql(array_strings.each{|i| p i+'2' })
        end

        it "test my each method with no block given, expects #enumerator with same array" do
            puts "same array - converts output to array"
            expect(array_strings.my_each.to_a).to eql(array_strings.each.to_a)
            puts "same class enumerator"
            expect(array_strings.my_each.class).to eql(array_strings.each.class)
        end


    end
end 