require 'rails_helper'

RSpec.describe 'METHOD /users', type: :request do
  it 'foo' do
    get('/users')
    expect(response.status).to eq(200)
  end

  it 'foo' do
    User.create(email: 'foo@bar', password: 'sha111111111')
    get('/users')
    expect(response.parsed_body).to include(include(
      'email' => 'foo@bar',
      'password_digest' => an_instance_of(String)
    ))
  end

  it 'creates user' do
    expect { post('/users', params: { email: 'foo@bar', password: 'bugagaga' }) }.to change { User.count }.by(1)
    expect(User.last.attributes).to include(
      'email' => 'foo@bar',
      'password_digest' => an_instance_of(String)
    )
  end
end
