module SMS
  class XpeedClient
    include ClientMethods
    
    def login(id, password)
      page = @agent.get("http://imory.xpeed.com/member.im?cmd=loginForm")
      page = page.form_with(:name => "loginForm") do |form|
        form.mbrId = id
        form.mbrPasswd = password
      end.submit

      page = page.forms.first.submit
      page = @agent.get("http://imory10.xpeed.com/imory/sms/mobile/mobile2.php")

      page.form_with(:name => "phone_form") do |form|
        @remains = form.remainFreeStr.split(":").last.to_i
      end

      SMS.log.info "[Xpeed] Remains : #{remains} times" if SMS.log
      available?
    rescue Exception => e
      SMS.log.debug e if SMS.log
      false
    end

    def deliver(to, msg)
      return false unless super
      
      page = @agent.get("http://imory10.xpeed.com/imory/sms/mobile/mobile2.php")
      page.encoding = "EUC-KR"
      page.form_with(:name => "phone_form") do |form|
        form.action = "http://imory10.xpeed.com/imory/sms/mobile/msg_send.php"
        form.msg = msg
        form.remainFreeStr=""
        form.msglen = ""
        form.rCount = "1"
        form.phone = from
        form.recv = to
        form.sendTime = "now"
        form.resvFlag = "N"
        form.sendCount = "1"
      end.submit
      
      true
    end
  end
end