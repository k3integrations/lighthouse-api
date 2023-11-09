module Lighthouse
  class Base < ActiveResource::Base
    self.format = :xml

    def self.inherited(base)
      Lighthouse.resources << base
      class << base        
        attr_accessor :site_format
        
        def site_with_update
          Lighthouse.update_site(self)
          site_without_update
        end
        alias_method :site_without_update, :site
        alias_method :site, :site_with_update
      end
      base.site_format = '%s'
      super
      Lighthouse.update_token_header(base)
      Lighthouse.update_auth(base)
    end
  end
end
