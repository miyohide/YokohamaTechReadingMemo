# coding: utf-8

require 'date'
require 'active_record'

require_relative '../../app/models/tag_list'
require_relative 'taggable'

class Post < ActiveRecord::Base
   LIMIT_DEFAULT = 10

   include FigLeaf
   include Conversions
   # include Taggable

   # hide ActiveRecord::Base, ancestors: true,
   #    except: [Object, :init_with, :new_record?,
   #             :errors, :valid?, :save, :record_timestamps, :id, :id=]
   # hide_singletons ActiveRecord::Calculations,
   #                 ActiveRecord::FinderMethods,
   #                 ActiveRecord::Relation

   attr_accessible :title, :body, :pubdate, :image_url, :tags
   validates :title, presence: true

   attr_accessor :blog

   # serialize :tags

   # composed_of :tags, class_name: 'TagList', mapping: %w(tags tags),
   #    converter: ->(value) { TagList(value) }

   def publish(clock=DateTime)
      return false unless valid?
      self.pubdate ||= clock.now
      @blog.add_entry(self)
   end

   def self.most_recent(limit=LIMIT_DEFAULT)
      all(order: "pubdate DESC", limit: limit)
   end

   def self.first_before(date)
      first(conditions: ["pubdate < ?", date],
            order: "pubdate DESC")
   end

   def self.first_after(date)
      first(conditions: ["pubdate > ?", date],
            order: "pubdate ASC")
   end

   # def self.all_tags_alphabetical
   #    all_tags.alphabetical
   # end

   # def self.all_tags
   #    except(:limit).map(&:tags).reduce(TagList.new([]), &:+)
   # end
   #
   # def self.tagged(tag)
   #    select{ |e| e.tags.to_a.include?(tag) }
   # end

   def blog
      @blog ||= THE_BLOG
   end

   def picture?
      image_url.present?
   end

   def prev
      self.class.first_before(pubdate)
   end

   def next
      self.class.first_after(pubdate)
   end

   def up
      blog
   end

   def save(*)
      set_default_body
      super
   end

   private

   def set_default_body
      if body.blank?
         self.body = 'Nothing to see here'
      end
   end
end

