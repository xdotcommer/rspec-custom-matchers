$:.unshift File.dirname(__FILE__)

class CustomMatcher

  def self.create(class_name, &block)
    klass = Class.new(CustomMatcher)
    klass.send(:define_method, :matcher, &block) if block_given?
    Object.const_set(build_class_name(class_name), klass)
  end
  
  def initialize(*expected)
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
    case self.method(:matcher).arity
    when -1, 2..10 then matcher(@target, *@expected)
    when  1        then matcher(@target)
    when  0        then matcher()
    else fail
    end
  end

  def description *args
    class_display_name
  end
  
private

  def message(positive = true)
    expected = @expected.size == 1 ? @expected.first : @expected
    "#{positive ? 'Expected' : 'Did not expect'} #{@target.inspect} to #{class_display_name} #{expected.inspect if self.method(:matcher).arity == 2}"
  end
  
  def class_display_name
    self.class.to_s.gsub(/[A-Z]/) {|m| ' ' + m.downcase }.lstrip
  end
  
  def self.build_class_name(class_name)
    class_name.to_s.split('_').map {|s| s.capitalize}.join
  end
end

# module to include wherever you want the #matcher method defined
module CustomMatcher::Helper
  def matcher(name, context = self, &block)
    klass = CustomMatcher.create(name, &block)
    begin
      context.send(:define_method, name) { |*args| klass.new(*args) }
    rescue NoMethodError
      # the object we're trying to define this method on doesn't 
      # have a define_method method.  let's be nice and go ahead 
      # and try defining this method on the class of the object.
      context.class.send(:define_method, name) { |*args| klass.new(*args) }
    end
  end
end
