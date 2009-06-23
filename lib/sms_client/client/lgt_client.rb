module SMS
  class LgtClient
    include ClientMethods
    
    def login(id, password)
      @agent.get("http://www.lgtelecom.com/index.jsp") do |page|
        result = page.form_with(:name => "frm_login") do |form|
          form.login_id = id
          form.login_pw = password
        end.submit

        result = result.form_with(:name => "encForm").submit
      end

      page = @agent.get("http://www.lgtelecom.com/SmsLoginCmd.lgtservice")
      page = page.form_with(:name => "smsForm") do |form|
        form.action = "http://www.lgtelecom.com/jsp/mp/smsLogin.jsp"
      end.submit
      page = page.forms.first.submit
      page = @agent.get("http://cworld.ez-i.co.kr/mylgt2007/web2phone.asp")
      @remains = page.search(".mysms2_1 .accent").first.content.to_i
      super
    rescue Exception => e
      SMS.log.debug e if SMS.log
      false
    end

    def deliver(to, msg)
      return false unless super

      page = @agent.get("http://cworld.ez-i.co.kr/mylgt2007/web2phone.asp")
      page = page.iframes.first.click
      page = page.form_with(:name =>"phone") do |form|
        form.message = msg
        form.aliasphone = from
        form.asRphone = to
        form.multiRphone = to
        form.sendcheck = "Y"
        form.price = "20"
        form.phonecount = "0"
        form.namezmoney = "0"
      end.submit

      true
    end
  end
end