# coding: utf-8

require 'minitest/autorun'
require_relative '../spec_helper_lite'
require_relative '../../app/helpers/exhibits_helper'

stub_class 'PicturePostExhibit'
stub_class 'TextPostExhibit'
stub_class 'LinkExhibit'
stub_class 'Post'

describe ExhibitsHelper do
   before do
      @it = Object.new
      @it.extend ExhibitsHelper
      # Ruby 1.9.2と1.9.3との間での非互換性の関係でテキストにある
      # 内容ではテストに失敗する。
      # ここでは、newメソッドをstub化してテスト内容を修正した。
      # （参考）https://groups.google.com/forum/#!searchin/objects-on-rails/exhibits_helper_spec/objects-on-rails/3272cyA23OY/w1J_GNV5ayMJ
      stub(PicturePostExhibit).new { "PICTURE_POST_EXHIBIT" }
      stub(TextPostExhibit).new { "TEXT_POST_EXHIBIT" }
      @context = stub!
   end

   it "decorates picture posts with a PicturePostExhibit" do
      post = Post.new
      stub(post).picture? { true }
      @it.exhibit(post, @context).must_equal "PICTURE_POST_EXHIBIT"
   end

   it "decorates text posts with a TextPostExhibit" do
      post = Post.new
      stub(post).picture? { false }
      @it.exhibit(post, @context).must_equal "TEXT_POST_EXHIBIT"
   end

   it "leaves objects it doesn't know about alone" do
      model = Object.new
      @it.exhibit(model, @context).must_be_same_as(model)
   end
end

