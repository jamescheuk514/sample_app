FactoryGirl.define do
	factory :user do
		name                  'example user 1'
		email                 'example@example.com'
		password              'password'
		password_confirmation 'password'
	end
end