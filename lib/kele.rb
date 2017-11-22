require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)

    post_response = self.class.post(base_url("sessions"),
      body: { email: email, password: password } )

      @auth_token = post_response['auth_token']
      if @auth_token.nil?
        puts "Sorry, invalid credentials."
      end
  end

  def get_me
    get_me = self.class.get(base_url("users/me"), headers: { "authorization" => @auth_token })
    JSON.parse(get_me.body)
  end

  def get_mentor_availability(mentor_id)
    get_mentor_availability = self.class.get("mentors/#{mentor_id}/student_availability",headers: {"authorization" => @auth_token})
    JSON.parse(get_mentor_availability.body)
  end

  def get_messages(page_number = nil)
    if page_number == nil
     get_messages = self.class.get(base_url("message_threads"),headers: {"authorization" => @auth_token})
   else
     get_messages = self.class.get(base_url("message_threads?page=#{page_number}"),headers: {"authorization" => @auth_token})
   end
    JSON.parse(get_messages.body)
  end

  def create_message(sender_id, recipient_id, stripped_text, subject, token=nil)
    options = {body: {
                sender: sender_id,
                recipient_id: recipient_id,
                subject: subject,
                "stripped-text" => stripped_text},
                headers: {"authorization" => @auth_token}
              }
    options[:token] = token if token
    self.class.post(base_url("messages"), options)
  end

  def base_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

  #me.create_message({sender_id: 2336726, recipient_id: 2345139, token: @auth_token, subject: 'Sample Subject', striped_text: 'Sample Stripped Text'})
end
