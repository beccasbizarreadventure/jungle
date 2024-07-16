require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(
        first_name: 'Test',
        last_name: 'Test',
        email: 'bunny@bunny',
        password: 'bunny123',
        password_confirmation: 'bunny123'
      )
    end

    it 'is not valid without a password and password_confirmation' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid if password and password_confirmation are not the same' do
      @user.password_confirmation = 'bunny1234'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is valid if password and password_confirmation are the same' do
      expect(@user).to be_valid
    end

    it 'is not valid if email is not unique' do
      @user.save
      user2 = User.new(
        first_name: 'Test',
        last_name: 'Test',
        email: 'bunny@bunny',
        password: 'bunny123',
        password_confirmation: 'bunny123'
      )
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'is not valid only if email, first and last name are present' do
      @user.email = nil
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank", "Last name can't be blank", "Email can't be blank")
    end

    it 'is valid only if email, first and last name are present' do
      expect(@user).to be_valid
    end

    it 'is not valid if password length is less than 6' do
      @user.password = 'bun'
      @user.password_confirmation = 'bun'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # authenticate_with_credentials should return nil if the email does not exist in the database
    it 'should return nil if the email does not exist in the database' do
      expect(User.authenticate_with_credentials('bunny@bun', 'bunny123')).to be_nil
    end
    it 'should return nil if the email and password are not a correct match' do
      expect(User.authenticate_with_credentials('bunny@bunny', 'password')).to be_nil
    end
    it 'returns a user if the email and password are correct' do
      expect(User.authenticate_with_credentials('bunny@bunny', 'bunny123')).to eq(@user)
    end
    it 'returns a user even if white spaces are included in the user email' do
      expect(User.authenticate_with_credentials('    bunny@bunny      ', 'bunny123')).to eq(@user)
    end
    it 'return a user even if the email is written in the wrong case' do
      expect(User.authenticate_with_credentials('bUnny@bUnny', 'bunny123')).to eq(@user)
    end
  end
end