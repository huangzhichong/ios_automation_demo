require "rest-client" rescue false
require "json"
######################################################################
# email should include the domain "@mailinator.com" 
# e.g email: "jbc123@mailinator.com" 

# instance one mailinator email box
# inbox = Utilities::Mailinator.new("jbc123@mailinator.com")
#
# get body by include subject  
# inbox.get_email_body_by_subject("temp")
#
# get body by from  
# inbox.get_email_body_by_from("Jabco.Shen@activenetwork.com")

# get body by include subject and from  
# inbox.get_email_body_by_subject_and_from("temp","Jabco.Shen@activenetwork.com")

# check email exist in inbox by email subject
# inbox.check_email_exist_by_subject("temp")
######################################################################
module Utilities
  class Mailinator
    def initialize(email)
      @token = "b0b09aabeb7f450bb4f12c85c769866d"
      @user_name = email.split("@")[0]
      @inbox = inbox
    end
    
    def inbox
      url = "https://api.mailinator.com/api/inbox?to=#{@user_name}&token=#{@token}" 
      begin
        result = RestClient.get url
        Common.logger_info "get by #{url} successfully!"
        JSON.parse(result)
      rescue => e
        Common.logger_error "error in get response from url: -- #{url} \n #{e.message}"
        result = nil
      end
    end
    
    def get_email_id_by_conditions(conditions=[])
      id = nil
      condition_str = "true"
      conditions.each do |condition|
        condition_str = "#{condition_str} && " + "message[\"#{condition["property"]}\"].include?(\"#{condition["value"]}\")"
      end
      Common.logger_info "conditon str: #{condition_str}"
      if @inbox["messages"].length == 0
        Common.logger_info "email box is null, please check user name:#{@user_name} if belong to domain @mailinator.com"
        return nil  
      end
      messages = @inbox["messages"].reverse
      messages.each do |message|
        if eval(condition_str)
          id = message["id"]
          return id
        end
      end
      id
    end
    
    
    def get_email_object_by_conditions(conditions=[])
      email_id = get_email_id_by_conditions(conditions)
      url = "https://api.mailinator.com/api/email?id=#{email_id}&token=#{@token}"
      # email_id = get_email_id_by_property(include_subject,"subject")
      if email_id.nil?
        Common.logger_info "#{__method__} failed, can't find the email by its condition:#{conditions}"  
        return nil
      end
      begin
        result = RestClient.get url
        Common.logger_info "get by #{url} successfully!"
        return JSON.parse(result)
      rescue => e
        Common.logger_error "error in get response from url: -- #{url} \n #{e.message}"
        return nil
      end
    end
    
    def get_email_body_by_email_object(email_object,format=:html)
      return nil if email_object.nil?
      if format.to_sym == :html
        email_object["data"]["parts"].last["body"] 
      else
        email_object["data"]["parts"].first["body"]
      end
    end
    
    def check_email_exist_by_subject(include_subject)
      conditions = [{"property" => "subject","value" => include_subject}]
      email = get_email_object_by_conditions(conditions)
      unless email.nil?
        Common.logger_info "#{__method__}(#{include_subject}).passed"
      else
        Common.logger_error "#{__method__}(#{include_subject}).failed, inbox is:#{@inbox}"
      end
    end
    
    def get_email_body_by_subject(include_subject,format=:html)
      conditions = [{"property" => "subject","value" => include_subject}]
      email = get_email_object_by_conditions(conditions)
      get_email_body_by_email_object(email,format)
    end
    
    def get_email_body_by_from(from,format=:html)
      conditions = [{"property" => "fromfull","value" => from}]
      email = get_email_object_by_conditions(conditions)
      get_email_body_by_email_object(email,format)
    end
    
    def get_email_body_by_subject_and_from(include_subject,from,format=:html)
      conditions = [{"property" => "subject","value" => include_subject},{"property" => "fromfull","value" => from}]
      email = get_email_object_by_conditions(conditions)
      get_email_body_by_email_object(email,format)
    end
  end
end