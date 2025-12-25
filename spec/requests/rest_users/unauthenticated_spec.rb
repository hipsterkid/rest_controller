require 'rails_helper'

RSpec.describe 'REST /users unauthenticated', type: :request do
  it 'forbidden with GET /users' do
    get('/users')
    expect(response).to have_http_status(:forbidden)
  end

  it 'forbidden with GET /users' do
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

  it 'forbidden with POST /users' do
    expect { post('/users', params: { email: 'foo@bar', password: 'bugauguga123' }) }.not_to \
      change { User.count }
    expect(User.last).to be_nil
    expect(response).to have_http_status(:forbidden)
  end

  it 'forbidden with POST /users without password' do
    expect { post('/users', params: { email: 'foo@bar' }) }.not_to change { User.count }
    expect(response).to have_http_status(:forbidden)
  end

  it 'forbidden with PUT /users/:id' do
    User.create(email: 'foo@bar', password: 'bugauguga123')
    user = User.last
    expect { put("/users/#{user.id}", params: { email: 'bar@foo' }) }.not_to \
      change { user.reload.email }
    expect(response).to have_http_status(:forbidden)
  end

  it 'forbidden with DELETE /users/:id' do
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
