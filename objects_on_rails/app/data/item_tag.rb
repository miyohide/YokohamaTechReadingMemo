# coding: utf-8

class ItemTag < ActiveRecord::Base
   belongs_to :tag
   belongs_to :item, polymorphic: true
   delegate :name, to: :tag

   attr_accessible :tag, :item
end

