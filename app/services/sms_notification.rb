# frozen_string_literal: true

require 'uri'
require 'net/http'
class SmsNotification
  attr_reader :phone
  def initialize(content_data, phone)
    @phone = phone.to_s.include?("+") ? phone.to_s[3..-1] : phone.to_s
    @phone = @phone.to_i
    @content = content_data
  end

  def call
    puts phone
    Rails.logger.debug phone
    Rails.logger.debug "DEBUG __--"
    return nil unless [7892517159, 8884449305, 8884445923].include?(phone.to_i)
    user = 'MAFTrans'
    authkey = '92S2Vp4uiHfcU'
    sender = 'UFJEDU'
    template_map = {
      'order_created' => {
                          content: "Dear %{name}, Thank you for placing the order %{order_number} with Uniform Junction. We have received the amount of %{order_total}.-Uniform Junction",
                          template_id: 1707162321897752798
                        }
    }

    data = template_map['order_created']
    
    url = URI("http://sms1x.knowlarity.com/api/pushsms?user=#{user}&authkey=#{authkey}&sender=#{sender}&mobile=#{phone}&summary=1&output=json&entityid=1701162079335709541&templateid=#{data[:template_id]}&#{URI.encode_www_form([["text", data[:content] %  @content]])}")

    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)

    response = http.request(request)
    response.read_body
  end
end
