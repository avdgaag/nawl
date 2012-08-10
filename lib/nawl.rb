require 'nawl/null_object'
require 'nawl/version'

module Nawl
  def self.included(base)
    base.extend ClassMethods
  end

  # Create a dummy object that responds to a given message with the
  # given return value. You can specify a train wrek of nested objects
  # by joining multiple messages with a dot.
  #
  # @example Create a one-off object
  #     chain('foo', 'bar').foo # => 'bar'
  # @example Create nested objects
  #     chain('foo.bar.baz', 'qux').foo.bar.baz # => 'qux'
  # @param [String] path one or more messages to be stubbed
  # @param [Object] return_value the return value at the end of the chain
  # @return [Object]
  def chain(path, return_value)
    messages = path.split '.'
    message  = messages.shift
    new_path = messages.join '.'
    value    = messages.any? ? chain(new_path, return_value) : return_value
    Object.new.tap do |o|
      o.define_singleton_method(message) { |*args| value }
    end
  end

  module_function :chain

  module ClassMethods
    # Associate a single null object with the current class. The null object
    # will respond to all the regular model's methods with their default values,
    # usually nil -- or a value you explicitly set.
    #
    # You can get the the object instance using `Model.null_object`.
    #
    # @example define simple null object
    #     class Post
    #       include Nawl
    #       has_null_object
    #     end
    #     Post.null_object.title # => nil
    # @example explicitly set return values
    #     class Post
    #       include Nawl
    #       has_null_object author: 'anonymous'
    #     end
    #     Post.null_object.author # => 'anonymous'
    # @param [Hash] options that define explicit return values
    def has_null_object(options = {})
      null_object_stubs = columns.inject({}) do |h, column|
        h.merge column.name => column.default
      end
      null_object_stubs.merge! options
      class_name = self
      const_name = "Null#{class_name}".to_sym
      const_set(const_name, Class.new(NullObject) {
        null_object_stubs.each do |method, value|
          return_value = value.nil? ? self : value
          define_method(method) { |*args| return_value }
          define_method(:class) { class_name }
        end
      })
      @null_object = const_get(const_name).new
    end

    attr_reader :null_object
  end
end
