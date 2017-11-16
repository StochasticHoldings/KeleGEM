require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap
  def initialize(email, password)
    post_response = self.class.post('/sessions',
      body: { email: email, password: password } )
      @auth_token = post_response['auth_token']
      if @auth_token.nil?
        puts "Sorry, invalid credentials."
      end
  end

  def get_me
    get_me = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(get_me.body)
  end

  def get_mentor_availability(mentor_id)
    get_mentor_availability = self.class.get("/mentors/#{mentor_id}/student_availability",headers: {"authorization" => @auth_token})
    JSON.parse(get_mentor_availability.body)
  end
end
