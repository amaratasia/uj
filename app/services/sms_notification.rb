# frozen_string_literal: true

require 'uri'
require 'net/http'
class SmsNotification
  def initialize(content, phone)
    @phone = phone
    @content = content
  end

  def call
    password = 'New@2021'
    user = 'MAFTrans'
    url = URI("http://message.knowlarity.com/api/mt/SendSMS?user=#{user}&password=#{password}&senderid=SBKMSG&channel=Trans&DCS=0&flashsms=0&number=91#{@phone}&text=#{@content}")
    puts url
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    response.read_body
  end
end
