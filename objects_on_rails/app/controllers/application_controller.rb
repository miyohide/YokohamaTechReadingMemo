class ApplicationController < ActionController::Base
   include ExhibitsHelper
   protect_from_forgery

   def blog_url(*)
      root_url
   end

   private
   def blog
      @blog ||= exhibit(THE_BLOG)
   end
   helper_method :blog
end
