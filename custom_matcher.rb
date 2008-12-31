class CustomMatcher
  def self.create(class_name, &block)
    klass = Class.new(CustomMatcher)
    klass.send(:define_method, :matcher, &block) if block_given?
    Object.const_set(build_class_name(class_name), klass)
  end
  
  def initialize(expected = nil)
    @expected = expected
  end
  
  def failure_message
    message
  end

  def negative_failure_message
    message(false)
  end
  
  def matcher(target, expected)
    target == expected
  end
  
  def matches?(target)
    @target = target
    if self.method(:matcher).arity == 2
      matcher(@target, @expected)
    else
      matcher(@target)
    end
  end
  
private
  def message(positive = true)
    "#{positive ? 'Expected' : 'Did not expect'} #{@target.inspect} to #{class_display_name} #{@expected.inspect if self.method(:matcher).arity == 2}"
  end
  
  def class_display_name
    self.class.to_s.gsub(/[A-Z]/) {|m| ' ' + m.downcase }.lstrip
  end
  
  def self.build_class_name(class_name)
    class_name.to_s.split('_').map {|s| s.capitalize}.join
  end
end

def matcher(name, &block)
  klass = CustomMatcher.create(name, &block)
  self.class.send(:define_method, name) { |*args| klass.new(*args) }
end