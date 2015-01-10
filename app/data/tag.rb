# coding: utf-8

class Tag < ActiveRecord::Base
   has_many :item_tags
end

