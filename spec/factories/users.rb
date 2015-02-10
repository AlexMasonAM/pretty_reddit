FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString@example.com"
    password "pass123"
    password_confirmation "pass123"
  end
end
