require 'spec_helper'

describe 'UserPages' do
	subject { page }


	describe 'profit page' do
		let(:user) { FactoryGirl.create(:user)}
		before { visit user_path(user)}
		it { should have_content(user.name) }
		it { should have_title(full_title(user.name)) }
	end

	describe 'signup page' do
		before { visit signup_path }

		it { should have_content('Sign Up') }
		it { should have_title(full_title('Sign Up'))}
	end

	describe 'sign up' do
		before { visit signup_path }
		let(:submit) { 'Create My Account' }

		describe 'with invalid info' do
			it 'should not create a user' do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
		describe 'with valid info' do
			before do
				fill_in 'Name',                  with: 'Example User 2'
				fill_in 'Email',                 with: 'example@exapmle.com'
				fill_in 'Password',              with: 'password'
				fill_in 'Confirmation', with: 'password'
			end

			it 'should create a user' do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end
