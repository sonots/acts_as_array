module ActsAsArray
  def self.included(klass)
    klass.extend(ClassMethods)
  end
end
