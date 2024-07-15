require 'rails_helper'

RSpec.describe User, type: :model do
#It must be created with a password and password_confirmation fields
it 'is not valid without a password and password_confirmation' do
  user = User.new(first_name: 'Test', last_name: 'Test', email: 'bunny@bunny', password: nil, password_confirmation: nil)
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("Password can't be blank")
end
#These need to match so you should have an example for where they are not the same
it 'is not valid if password and password_confirmation are not the same' do
  user = User.new(first_name: 'Test', last_name: 'Test', email: 'bunny@bunny', password: 'bunny123', password_confirmation: 'bunny1234')
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
end
it 'is valid if password and password_confirmation are the same' do
  user = User.new(first_name: 'Test', last_name: 'Test', email: 'bunny@bunny', password: 'bunny123', password_confirmation: 'bunny123')
  expect(user).to be_valid
end
#Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
it 'is not valid if email is not unique' do
  user1 = User.create(first_name: 'Test', last_name: 'Test', email: 'bunny@bunny', password: 'bunny123', password_confirmation: 'bunny123')
  user2 = User.new(first_name: 'Test', last_name: 'Test', email: 'bunny@bunny', password: 'bunny123', password_confirmation: 'bunny123')
  expect(user2).to_not be_valid
  expect(user2.errors.full_messages).to include("Email has already been taken")
end
#Email, first name, and last name should also be required
it 'is not valid only if email, first and last name are present' do
  user = User.new(first_name: nil, last_name: nil, email: nil, password: 'bunny123', password_confirmation: 'bunny123')
  expect(user).to_not be_valid
  expect(user.errors.full_messages).to include("First name can't be blank", "Last name can't be blank", "Email can't be blank")
end
it 'is valid only email, first and last name are present' do
  user = User.new(first_name: 'Test', last_name: 'Test', email: 'bunny@bunny', password: 'bunny123', password_confirmation: 'bunny123')
  expect(user).to be_valid
end
#The password must have a minimum length when a user account is being created
end
