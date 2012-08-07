module Nawl
  # The null object will respond to any message with nil. When converted to
  # other objects, it chooses sane "empty" values.
  class NullObject
    def to_s
      ''
    end

    def to_a
      []
    end

    def to_h
      {}
    end

    def to_i
      0
    end

    def to_f
      0.0
    end

    def method_missing(name, *args)
      nil
    end

    def inspect
      '#<NullObject:0x%08x>' % (object_id * 2)
    end
  end
end
