# coding: utf-8

module Conversions
   # privateなのは、includeしたClass以外は呼べないようにするため
   private
   def TagList(value)
      return value if value.is_a?(TagList)
      TagList.new(value)
   end
end

class TagList
   extend Forwardable

   attr_reader :tags

   def_delegators :tags, :empty?, :to_a, :each

   def initialize(tags)
      case tags
      when Array
         @tags = tags
      when nil
         @tags = []
      else
         @tags = tags.split(/\W+/)
      end
      @tags.each(&:downcase!)
      @tags.uniq!
   end

   def to_s
      @tags.join(", ")
   end

   def to_ary
      @tags
   end

   def +(other)
      self.class.new(to_a + other.to_a)
   end

   def ==(other)
      ## other.to_aとしないのは、otherがStringのときにto_aが落ちるため
      to_a == Array(other)
   end

   def alphabetical
      self.class.new(tags.sort)
   end
end

