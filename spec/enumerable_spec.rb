require "./main"
RSpec.describe Enumerable do
    let(:array1) {[1,2,3,4,5,6,7,8,9,10]}
    let(:array_strings) {%w[cat dog monkey lion elephant]}
    let(:array_mix) {[1, "b", 3.14]}
    let(:all_nil) {[nil,nil,nil,nil]}

    describe "test my each method with different inputs" do
        it "test my_each method with array of integers" do
            expect(array1.my_each{|i| p i+1 }).to eql(array1.each{|i| p i+1 })
        end

        it "test my each method with array of strings" do
            expect(array_strings.my_each{|i| p i+'1' }).to eql(array_strings.each{|i| p i+'2' })
        end

        it "test my each method with no block given, same array - converts output to array" do
            expect(array_strings.my_each.to_a).to eql(array_strings.each.to_a)
        end

        it "test my each method with no block given, same class enumerator" do
            expect(array_strings.my_each.class).to eql(array_strings.each.class)
        end
    end

    describe "test my_each_with_index method with different inputs" do
        it "test my_each_with_index ckeck on index values within an array" do
            count = 0
            array1.my_each_with_index do |a,x|
                expect(count).to eql(x)
                count += 1
            end
        end
        it "test my_each_with_index method with no block given, same array - converts output to array" do
            expect(array_strings.my_each_with_index.to_a).to eql(array_strings.each_with_index.to_a)
        end

        it "test my_each_with_index method with no block given, same class enumerator" do
            expect(array_strings.my_each_with_index.class).to eql(array_strings.each.class)
        end
    end

    describe "test my_select method with different inputs" do
        it "test my_selec to select even numbers after operation is applied (x+1)" do
            expect(array1.my_select { |x| (x + 1).even? }).to eql(array1.select { |x| (x + 1).even? })
        end
        it "test my_selec returns a Enumerable when no block given" do
            expect(array1.my_select.class).to eql(array1.select.class)
        end
    end

    describe "test my_all method with different inputs" do
        it "test my_all to check for elements with length >=3" do
            expect(array_strings.my_all? { |word| word.length >= 3 }).to eql(array_strings.my_all? { |word| word.length >= 3 })
        end
        it "test my_all to look for a special regexp character 'a'" do
            expect(array_strings.my_all?(/a/)).to eql(array_strings.my_all?(/a/))
        end
        it "test my_all to match a 'Numeric' data type " do
            expect(array_mix.my_all?(Numeric)).to eql(array_mix.my_all?(Numeric))
        end

    end

    

    


end 