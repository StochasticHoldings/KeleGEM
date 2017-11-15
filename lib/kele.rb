require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
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

  def get_mentor_availability
    get_mentor_availability = self.class.get('mentors/2345139/student_availability',headers: {"authorization" => @auth_token})
    JSON.parse(get_mentor_availability.body)
  end

end
