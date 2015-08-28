require 'pdf/reader'

module Utilities
  module PDF
    class << self
      def check_data_by_keyword(filelocation,keyword, keyword_value)
        pagecontent = ""
        PDF::Reader.open(filelocation) do |reader|
          reader.pages.each do |page|
            pagecontent << page.text
          end
        end
        if pagecontent.include?keyword
          beginIndex = pagecontent.index(keyword)
          endIndex = beginIndex+pagecontent[beginIndex, pagecontent.length].index("\n")
          value = pagecontent[beginIndex+keyword.length..endIndex]
          
          if keyword_value.to_s == value.to_s.chomp
            Common.logger_info "The check value is correct."
          else
            Common.logger_error "current page's key word is not equal #{keyword_value}"
          end
        else
          Common.logger_error "current page not contain the key word #{keyword}"
        end
      end
    end
  end
end
