require 'rails_helper'

RSpec.describe 'REST /users', type: :request do
  it 'gets empty list with GET /users' do
    get('/users')
    expect(response).to have_attributes(status: 200, parsed_body: [])
  end

  it 'gets list values with GET /users' do
    [
      { email: 'foo1@bar1', password: 'bugauguga123' },
      { email: 'foo2@bar2', password: 'bugauguga123' }
    ].each { |attrs| User.create!(attrs) }
    get('/users')
    expect(response).to have_attributes(
      status: 200,
      parsed_body: include(
        include(email: 'foo1@bar1'),
        include(email: 'foo2@bar2')
      )
    )
  end

  it 'creates user with POST /users' do
    expect { post('/users', params: { email: 'foo@bar', password: 'bugauguga123' }) }.to \
      change { User.count }.by(1)
    expect(User.last.attributes).to include(
      'email' => 'foo@bar',
      'password_digest' => an_instance_of(String)
    )
  end

  it 'not creates user with POST /users without password' do
    expect { post('/users', params: { email: 'foo@bar' }) }.not_to change { User.count }
  end

  it 'updates user with PUT /users/:id' do
    User.create(email: 'foo@bar', password: 'bugauguga123')
    user = User.last
    expect { put("/users/#{user.id}", params: { email: 'bar@foo' }) }.to \
      change { user.reload.email }.from('foo@bar').to('bar@foo')
  end

  it 'destroys user with DELETE /users/:id' do
    [
      { email: 'foo1@bar1', password: 'bugauguga123' },
      { email: 'foo2@bar2', password: 'bugauguga123' }
    ].each { |attrs| User.create!(attrs) }
    user = User.first
    expect { delete("/users/#{user.id}") }.to change { User.count }.by(-1)
    expect(User.all).not_to include(have_attributes(email: 'foo1@bar1'))
  end
end
