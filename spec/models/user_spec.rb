require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    context 'Passwords' do
      it 'should match' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'david@gmail.com', password: 'sword', password_confirmation: 'fish')
        expect(@user.errors.full_messages).to include('Password confirmation doesn\'t match Password')
      end
      it 'should have password confirmation' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'david@gmail.com', password: 'sword', password_confirmation: '')
        expect(@user.errors.full_messages).to include('Password confirmation doesn\'t match Password')
      end
      it 'should have a minimum length' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'david@gmail.com', password: '', password_confirmation: '')
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 1 character)')
      end
    end

    context 'should fail if email in database' do
      it 'is identical to the new user\'s email' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        @user2 = User.create(first_name: 'donald', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
      it 'only differs from the new user\'s email in its case' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        @user2 = User.create(first_name: 'donald', last_name: 'hofsteder', email: 'DHOF@GMAIL.COM', password: 'sword', password_confirmation: 'sword')
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'should work' do
      it 'with the correct email and password' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        expect(@user.authenticate_with_credentials('dhof@gmail.com', 'sword').id).to be @user.id
      end
      it 'with a correct email having leading/trailing spaces and a correct password' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        expect(@user.authenticate_with_credentials('  dhof@gmail.com  ', 'sword').id).to be @user.id
      end
      it 'with a correct email having the wrong case, and a correct password' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        expect(@user.authenticate_with_credentials('DHOF@GMAIL.COM', 'sword').id).to be @user.id
      end
    end
    context 'shouldn\'t work' do
      it 'with the wrong email' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        expect(@user.authenticate_with_credentials('dhof@email.com', 'sword')).to be false
      end
      it 'with the wrong password' do
        @user = User.create(first_name: 'david', last_name: 'hofsteder', email: 'dhof@gmail.com', password: 'sword', password_confirmation: 'sword')
        expect(@user.authenticate_with_credentials('dhof@gmail.com', 'stone')).to be false
      end
    end
  end
end