require 'active_support/core_ext'

module ActsAsArray
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    # acts_as_array :has_many_field => {:class => Class, :field => :name}
    def acts_as_array(params = {})
      params.each do |field, opts|
        opts[:class] ||= field.to_s.singularize.capitalize.constantize
      end
      self.class_eval do
        params.each do |field, opts|
          # Setter with an array mapper
          #
          # Example:
          #
          # mails = ['a@a.com', 'b@b.com']
          #
          # instead of
          # 
          # mails = [Mail.new(name: 'a@a.com'), Mail.new(name: 'b@b.com')]
          unless method_defined?("#{field}_with_arraymap=")
            define_method("#{field}_with_arraymap=") do |raw_array|
              obj_array = __send__("make_#{field}", raw_array)
              __send__("#{field}_without_arraymap=", obj_array)
            end
            define_method("#{field}=") {|*args| } unless method_defined?("#{field}=")
            alias_method("#{field}_without_arraymap=", "#{field}=")
            alias_method("#{field}=", "#{field}_with_arraymap=")
          end

          # Getter with an array mapper
          #
          # Example:
          #
          # mails #=> ['a@a.com', 'b@b.com']
          #
          # instead of
          #
          # mails #=> [Mail.new(name: 'a@a.com'), Mail.new(name: 'b@b.com')]
          unless method_defined?("#{field}_with_arraymap")
            define_method("#{field}_with_arraymap") do
              obj_array = __send__("#{field}_without_arraymap")
              obj_array.map {|obj| obj.__send__(opts[:field]) }
            end
            define_method("#{field}") { } unless method_defined?("#{field}")
            alias_method("#{field}_without_arraymap", "#{field}")
            alias_method("#{field}", "#{field}_with_arraymap")
          end

          # Get the original object array
          #
          # Example:
          #
          # obj_mails #=> [Mail.new(name: 'a@a.com'), Mail.new(name: 'b@b.com')]
          define_method("obj_#{field}") do
            __send__("#{field}_without_arraymap")
          end

          # Convert the single value array to object array
          #
          # Example:
          #
          # make_mails(['a@a.com', 'b@b.com'])
          # #=> [Mail.new(name: 'a@a.com'), Mail.new(name: 'b@b.com')]
          #
          # Note:
          #
          # This method uses the `#find_or_initialize_by` method internally
          define_method("make_#{field}") do |raw_array|
            return nil unless raw_array
            raw_array.map {|val| opts[:class].find_or_initialize_by(opts[:field] => val) }
          end
        end
      end
    end
  end
end
