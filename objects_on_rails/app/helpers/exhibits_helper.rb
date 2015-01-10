# coding: utf-8

require_relative '../../app/exhibits/exhibit'

module ExhibitsHelper
   def exhibit(model, context = self)
      Exhibit.exhibit(model, context)
   end
end

