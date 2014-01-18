require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
  	assert_nothing_raised do
  		UserFriendship.create user: users(:kieran), friend: users(:mike)
	end  
  end

  test "that creating a friendship based on user is and friend id works" do
  	UserFriendship.create user_id: users(:kieran).id, friend_id: users(:mike).id
  	assert users(:kieran).friends.include?(users(:mike))
  end
end
