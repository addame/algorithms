$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')
require 'algorithms'

if defined? Containers::CBst
  describe "CBst" do
    it "should mark ruby object references" do
      anon_key_class = Class.new do
        attr :value
        def initialize(x); @value = x; end
        def <=>(other); value <=> other.value; end
      end
      anon_val_class = Class.new
      @bst = Containers::CBst.new
      100.times { |x| @bst.insert(anon_key_class.new(x), anon_val_class.new) }
      # Mark and sweep
      ObjectSpace.garbage_collect
      # Check if any instances were swept
      ObjectSpace.each_object(anon_key_class).count.should eql(100)
      ObjectSpace.each_object(anon_val_class).count.should eql(100)
    end
  end
end