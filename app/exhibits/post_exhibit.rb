# coding: utf-8

require_relative 'exhibit'

class PostExhibit < Exhibit
   def tags
      exhibit(Taggable(to_model).tags)
   end
end

