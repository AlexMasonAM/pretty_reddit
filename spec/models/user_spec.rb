require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
    # expect(:user).to respond_to(:email)
  end
  
  it 'is invalid without a name' do
    user.name = nil
    expect(user).to be_invalid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).to be_invalid
  end

  it 'is invalid if email is not formatted properly' do
    user.email = 'asdfgh'
    expect(user).to be_invalid
  end

  it 'is invalid if email already exists' do
    user = FactoryGirl.create(:user, email: 'jack@gmail.com')

    user1 = FactoryGirl.build(:user, email: 'jack@gmail.com')

    user2 = FactoryGirl.build(:user, email: 'jack@gmail.com')

    expect(user1).to be_invalid
    expect(user2).to be_invalid
  end
  
  it 'should require password confirmation' do
    
    user = FactoryGirl.create(:user)
    user.password_confirmation = nil
    expect(user).to be_invalid
  end

  it 'should confirm password' do
    
    user = FactoryGirl.create(:user)
    user.password = "a" * 8
    user.password_confirmation = "bbbbbbbb"
    expect(user).to be_invalid
  end
  it 'should have a minimum length of 6 characters for password' do
    
    user = FactoryGirl.create(:user)
    user.password = user.password_confirmation = "a" * 5
    expect(user).to be_invalid
  end

end