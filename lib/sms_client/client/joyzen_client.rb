module SMS
  class JoyzenClient
    include ClientMethods
    
    def login(id, password)
      @agent.follow_meta_refresh = true

      page = @agent.get("http://www.joyzen.co.kr/member/login_01.html?login_url=http%3A%2F%2Fwww.joyzen.co.kr%2Fmember%2Flogin_01.html")
      page = page.form_with(:name => "login") do |form|
        form.member_id = id
        form.member_pw = password
      end.submit

      page = @agent.get("http://www.joyzen.co.kr/community/message/pop_message.html")
      page = @agent.get("http://www.joyzen.co.kr/community/message/pop_message.html")
      @remains = page.search("tr td font strong").first.content.to_i

      SMS.log.info "[Joyzen] Remains : #{remains} times" if SMS.log
      available?
    rescue Exception => e
      SMS.log.debug e if SMS.log
      false
    end

    def deliver(to, msg)
      return false unless super
      
      page = @agent.get("http://www.joyzen.co.kr/community/message/pop_message.html")
      page.form_with(:name => "smssingle") do |form|
        form.to_message = msg
        form.phone = from
        form.group_name1 = to
      end.submit
      
      true
    end
  end
end