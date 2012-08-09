require_relative '../../lib/nawl/null_object'

describe Nawl::NullObject do
  its(:to_s) { should == '' }
  its(:to_i) { should == 0 }
  its(:to_a) { should == [] }
  its(:to_f) { should == 0.0 }
  its(:to_h) { should == {} }
  its(:foo)  { should == subject }
end
