require 'rexml/document'

module Lighthouse
  module Formats
    module TicketXml
      include ActiveResource::Formats::XmlFormat
      extend self

      def decode(xml)
        doc = REXML::Document.new(xml)

        total_pages  = doc.root.elements['//total_pages']
        current_page = doc.root.elements['//current_page']

        doc.root.elements.delete(total_pages)
        doc.root.elements.delete(current_page)

        super(doc.to_s)
      end
    end
  end
end
