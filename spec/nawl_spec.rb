require_relative '../lib/nawl'

class Dummy
  Column = Struct.new(:name, :default)

  def self.columns
    [Column.new('title', nil), Column.new('price', 0)]
  end

  include Nawl
  has_null_object title: 'foo'
end

describe Nawl do
  describe '#chain' do
    it 'should create an object with a method that returns a value' do
      object = Nawl.chain 'foo', 'bar'
      object.foo.should == 'bar'
    end

    it 'should create nested objects with a return value' do
      object = Nawl.chain 'foo.bar.baz', 'qux'
      object.foo.bar.baz.should == 'qux'
    end
  end

  describe 'custom null objects' do
    subject { Dummy.null_object }
    it { should be_kind_of(Nawl::NullObject) }
    its(:title) { should == 'foo' }
    its(:price) { should == 0 }
    its(:class) { should == Dummy }
    its(:foo)   { should be_kind_of(Nawl::NullObject) }
  end
end
