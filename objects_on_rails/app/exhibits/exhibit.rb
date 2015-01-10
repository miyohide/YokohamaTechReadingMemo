require 'delegate'

class Exhibit < SimpleDelegator
   def initialize(model, context)
      @context = context
      super(model)
   end

   def self.exhibits
      [
         EnumerableExhibit,
         BlogExhibit,
         TextPostExhibit,
         PicturePostExhibit,
         LinkExhibit,
         TagListExhibit
      ]
   end

   def self.exhibit(object, context)
      return object if exhibited_object?(object)
      object = Exhibited.new(object, context)
      exhibits.inject(object) do |object, exhibit|
         exhibit.exhibit_if_applicable(object, context)
      end
   end

   def self.exhibit_if_applicable(object, context)
      if applicable_to?(object)
         new(object, context)
      else
         object
      end
   end

   def self.applicable_to?(object)
      false
   end

   def self.exhibited_object?(object)
      object.respond_to?(:exhibited?) && object.exhibited?
   end

   def self.exhibit_query(*method_names)
      method_names.each do |name|
         define_method(name) do |*args, &block|
            exhibit(super(*args, &block))
         end
      end
   end
   private_class_method :exhibit_query

   def self.object_is_any_of?(object, *classes)
      (classes.map(&:to_s) & object.class.ancestors.map(&:name)).any?
   end
   private_class_method :object_is_any_of?

   attr_reader :context

   def initialize(model, context)
      @context = context
      super(model)
   end

   alias_method :__class__, :class
   def class
      __getobj__.class
   end

   def exhibit(model)
      Exhibit.exhibit(model, context)
   end

   def to_partial_path
      if __getobj__.respond_to?(:to_partial_path)
         __getobj__.to_partial_path.dup
      else
         partialize_name(__getobj__.class.name)
      end
   end

   def render(template)
      template.render(partial: to_partial_path, object: self)
   end

   def to_model
      __getobj__
   end

   private
   class Exhibited < Exhibit
      def exhibit_chain
         []
      end

      def to_model
         __getobj__
      end
   end

   def partialize_name(name)
      "/#{name.underscore.pluralize}/#{name.demodulize.underscore}"
   end
end

