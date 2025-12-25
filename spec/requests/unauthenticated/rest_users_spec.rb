require 'rails_helper'

RSpec.describe 'REST /users', type: :request do
  it 'gets empty list with GET /users' do
    get('/users')
    expect(response).to have_http_status(:forbidden)
  end

  it 'gets list values with GET /users' do
    [
      { email: 'foo1@bar1', password: 'bugauguga123' },
      { email: 'foo2@bar2', password: 'bugauguga123' }
    ].each { |attrs| User.create!(attrs) }
    get('/users')
    expect(response.parsed_body).not_to include(
      include(email: 'foo1@bar1'),
      include(email: 'foo2@bar2')
    )
    expect(response).to have_http_status(:forbidden)
  end

  it 'creates user with POST /users' do
    expect { post('/users', params: { email: 'foo@bar', password: 'bugauguga123' }) }.not_to \
      change { User.count }
    expect(User.last).to be_nil
    expect(response).to have_http_status(:forbidden)
  end

  it 'not creates user with POST /users without password' do
    expect { post('/users', params: { email: 'foo@bar' }) }.not_to change { User.count }
  end

  it 'updates user with PUT /users/:id' do
    User.create(email: 'foo@bar', password: 'bugauguga123')
    user = User.last
    expect { put("/users/#{user.id}", params: { email: 'bar@foo' }) }.not_to \
      change { user.reload.email }
    expect(response).to have_http_status(:forbidden)
  end

  it 'destroys user with DELETE /users/:id' do
    [
      { email: 'foo1@bar1', password: 'bugauguga123' },
      { email: 'foo2@bar2', password: 'bugauguga123' }
    ].each { |attrs| User.create!(attrs) }
    user = User.first
    expect { delete("/users/#{user.id}") }.not_to change { User.count }
    expect(User.all).to include(
      have_attributes(email: 'foo1@bar1'),
      have_attributes(email: 'foo2@bar2'),
    )
    expect(response).to have_http_status(:forbidden)
  end
end
