# coding: utf-8

require 'minitest/autorun'

require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/link_exhibit'
require 'ostruct'

describe LinkExhibit do
   before do
      @next = Object.new
      @prev = Object.new
      @up = Object.new
      @context = Object.new
      @model = OpenStruct.new(
         next: @next, prev: @prev, up: @up
      )

      # serializable_hashはHashを返す。返すHashはキーが:model_data
      # で値は"MODEL_DATA"を取る
      stub(@model).serializable_hash { {model_data: "MODEL_DATA"} }

      stub(@context).url_for(@prev) { "URL_FOR_PREV" }
      stub(@context).url_for(@next) { "URL_FOR_NEXT" }
      stub(@context).url_for(@up)   { "URL_FOR_UP" }

      @it = LinkExhibit.new(@model, @context)
   end

   describe "#prev_url" do
      it "return a setting value when called with @prev arguments" do
         @it.prev_url.must_equal "URL_FOR_PREV"
      end
   end

   describe "#next_url" do
      it "return a setting value when called with @next arguments" do
         @it.next_url.must_equal "URL_FOR_NEXT"
      end
   end

   describe "#up_url" do
      it "return a setting value when called with @up arguments" do
         @it.up_url.must_equal "URL_FOR_UP"
      end
   end

   describe "#links_hash" do
      it "retun an Hash take the Array element" do
         @it.links_hash.must_be_instance_of Hash
         @it.links_hash["links"].must_be_instance_of Array
      end

      it "return an Array element included Hash element" do
         @it.links_hash["links"].must_include({"rel" => "prev", "href" => "URL_FOR_PREV"})
         @it.links_hash["links"].must_include({"rel" => "next", "href" => "URL_FOR_NEXT"})
         @it.links_hash["links"].must_include({"rel" => "up",   "href" => "URL_FOR_UP"})
      end
   end

   describe "#serializable_hash" do
      it "return a Hash with :model_data key" do
         @it.serializable_hash[:model_data].must_equal "MODEL_DATA"
      end
   end

   describe "#to_json" do
      it "return a JSON data" do
         @it.to_json.must_equal @it.serializable_hash.to_json
      end
   end
end

