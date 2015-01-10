# coding: utf-8

require 'rr'
require 'date'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

# nulldb_rspecのrequireはenvironmentのrequireの後に実施する必要あり
require 'nulldb_rspec'

class MiniTest::Unit::TestCase
   include RR::Adapters::MiniTest
end

def stub_module(full_name)
   full_name.to_s.split(/::/).inject(Object) do |context, name|
      begin
         context.const_get(name)
      rescue NameError
         context.const_set(name, Module.new)
      end
   end
end

def stub_class(full_name)
   full_name.to_s.split(/::/).inject(Object) do |context, name|
      begin
         context.const_get(name)
      rescue NameError
         context.const_set(name, Class.new)
      end
   end
end

module SpecHelpers
   def setup_nulldb
      schema_path = File.expand_path('../db/schema.rb', File.dirname(__FILE__))
      NullDB.nullify(schema: schema_path)
   end

   def teardown_nulldb
      NullDB.restore
   end
end

