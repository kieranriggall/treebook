require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:kieran).profile_name
  	assert !user.save
  	puts user.errors.inspect	
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Kieran', last_name: 'Riggall', email: 'kieran2@treebook.com')
    user.password = user.password_confirmation = '123qwe'

  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("must be formatted properly.")
  end

  test "user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Kieran', last_name: 'Riggall', email: 'kieran2@treebook.com')
    user.password = user.password_confirmation = '123qwe'

    user.profile_name = 'kriggall'
    assert user.valid?
  end

  test "that no error is raised when trying to access users friends" do 
    assert_nothing_raised do
      users(:kieran).friends
    end
  end

  test "creating freinds works" do
    users(:kieran).friends << users(:mike)
    users(:kieran).reload
    assert users(:kieran).friends.include?(users(:mike))
   end
end
