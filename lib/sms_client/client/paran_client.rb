module SMS
  class ParanClient
    include ClientMethods
    
    def login(id, password)      
      id, domain = id.split("@")
      page = @agent.get("http://www.paran.com")
      page = page.form_with(:name => "fmLogin") do |form|
        form.action = "http://main.paran.com/mainAction.do?method=paranMainLogin"
        form.wbUserid = id
        form.wbPasswd = password
        form.wbDomain = domain        
      end.click_button
      page = @agent.get("http://main.paran.com/paran/login_proc.jsp")
      page = @agent.get("http://mailsms.paran.com/")
      if page.search("#smsinfo a").first.content =~ /(\d+).*/
        @remains = $1.to_i
      end
      super
    rescue Exception => e
      SMS.log.debug e if SMS.log
      false
    end

    def deliver(to, msg)
      return false unless super

      page = @agent.get("http://mailsms.paran.com/send.html")
      page = page.form_with(:name => "smsForm") do |form|
        form.call = to
        form.phoneNum = from
        form.msg = msg
      end.submit

      true
    end
  end
end