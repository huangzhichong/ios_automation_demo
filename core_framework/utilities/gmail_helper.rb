require 'gmail' #working with ruby-gamil gem, add gem 'ruby-gmail', '~> 0.3.1' to Gemfile

######################################################################
# gmail = Utilities::GmailHepler.new("active.qa.rtp@gmail.com","Test123!")
#
# get subject of the latest email from address
# gmail.get_subject_of_latest_email_by_from("smart.huang@activenetwork.com")
#
# get body of the latest email after specific date
# body = gmail.get_body_of_latest_email_by_after(Date.parse("2014-04-15"))
#
# get body of the latest unread email on specific date
# body = gmail.get_body_of_latest_email_by_unread_and_on(true, Date.parse("2014-04-15"))
######################################################################
module Utilities
  class GmailHelper
    def initialize(email,password)
      @conditions = {}
      @gmail = Gmail.new(email, password)
      if @gmail
        @gmail.peek=true #don't mark emails as read on the server when downloading them
        Common.logger_info "Utilities::GmailHelper - connecting to gmail account #{email} - success."
      else
        Common.logger_error "Utilities::GmailHelper - connecting to gmail account #{email} - failed. unable to access."
      end
    end

    def method_missing(meth, *args, &block)
      case meth.to_s
      when /^get_emails_by_(.+)$/
        Common.logger_info "Utilities::GmailHelper - get emails by conditions #{@conditions} - success."
        get_emails_by_method($1,*args)
      when /^get_latest_email_by_(.+)$/
        begin
          email =  get_emails_by_method($1,*args).last
          Common.logger_info "Utilities::GmailHelper - get last email by conditions #{@conditions} - success."
          return email
        rescue Exception => e
          Common.logger_error "Utilities::GmailHelper - get last email by conditions #{@conditions} - failed. get error #{e}"
        end
      when /^get_subject_of_latest_email_by_(.+)$/
        begin
          subject = get_emails_by_method($1,*args).last.subject
          Common.logger_info "Utilities::GmailHelper - get subject of last email by conditions #{@conditions} - success."
          return subject
        rescue Exception => e
          Common.logger_error "Utilities::GmailHelper - get subject of last email by conditions #{@conditions} - failed. get error #{e}"
        end
      when /^get_body_of_latest_email_by_(.+)$/
        begin
          body = get_emails_by_method($1,*args).last.body.to_s
          Common.logger_info "Utilities::GmailHelper - get body string of last email by conditions #{@conditions} - success."
          return body
        rescue Exception => e
          Common.logger_error "Utilities::GmailHelper - get body string of last email by conditions #{@conditions} - failed. get error #{e}"
        end
      else
        super
      end
    end

    def get_emails_by_method(attrs,*args)
      attrs = attrs.split("_and_").map{|t| t.to_sym}
      @conditions = Hash[[attrs,args].transpose]
      return @gmail.inbox.emails(:read, @conditions) if @conditions.delete :read
      return @gmail.inbox.emails(:unread, @conditions) if @conditions.delete :unread
      @gmail.inbox.emails(@conditions)
    end
  end
end