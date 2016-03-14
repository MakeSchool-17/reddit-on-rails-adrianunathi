require 'test_helper'

class Api::V1::SubscriptionsControllerTest < ActionController::TestCase

  def setup
    @subboard = subboards(:bobs_board)
    @user = users(:james)
    @otheruser = users(:leila)
    @subscription = subscriptions(:leilas_subscription)
  end

  def teardown
    @subboard = nil
    @user = nil
  end

  test "should get all posts for post#index" do
    get :index
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal Subscription.all.length, response["subscriptions"].length
  end

  test "should create a subscription for subscription#create" do
    json = { format: 'json', username: @user.username,
                                             name: @subboard.name }
    post :create, json
    assert_response 201
  end

  test "should not create subscription with non-existing username for subscription#create" do
    json = { format: 'json', username: "blabla", name: @subboard.name }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 503
  end

  test "should not create subscription with non-existing subboard for subscription#create" do
    json = { format: 'json', username: @user.username, name: "blabla" }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 503
  end

  test "should not create duplicate subscription for subscription#create" do
    json = { format: 'json', username: @otheruser.username, name: @subboard.name }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 500
  end

  test "should delete a subscription for subscription#delete" do
    assert_difference 'Subscription.all.length', -1 do
      post :destroy , username: @otheruser.username
      assert_response 204
    end
  end

  test "should fail delete with non-existing username for subscription#destroy" do
    assert_no_difference 'Subscription.all.length' do
      post :destroy, username: 'blahblah'
      assert_response 503
    end
  end

  test "should fail delete with non-existing subscription for subscription#destroy" do
    assert_no_difference 'Subscription.all.length' do
      post :destroy, username: 'james'
      assert_response 503
    end
  end

end
