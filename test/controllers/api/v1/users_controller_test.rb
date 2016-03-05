require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:bob)
  end

  def teardown
    @user = nil
  end

  test "should get all users for users#index" do
    get :index
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal response["users"].length, User.all.length
    # assert_equal response["users"], User.all.as_json
  end

  test "should create user for users#create" do
    json = { format: 'json', user: { email: "test@test.com", username: "testing"}}
    post :create, json
    assert_response 201
  end

  test "should not create user for users#create" do
    json = { format: 'json', user: { email: "testtest.com", username: "t"}}
    post :create, json
    response = JSON.parse(@response.body)
    assert !response["error"].nil?, "Error should be present"
    assert !response["error"].empty?, "Error messages should be present"
    assert_response 500
  end

  test "should show user for users#show" do
    get :show, id: @user.id
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_equal response[:username], @user.username
    assert_response 200
  end

  test "should not show non-existing user for users#show" do
    get :show, id: 1
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert !response[:error].nil?, "Error should be present"
    assert_response 503
  end

  test "should delete user for users#destroy" do
    assert_difference 'User.all.length', -1 do
      post :destroy, id: @user.id
      assert_response 200
    end
  end

  test "should fail delete non-existing user for users#destroy" do
    assert_no_difference 'User.all.length' do
      post :destroy, id: 1
      assert_response 503
    end
  end

  test "should update user for users#update" do
    json = { format: 'json', id: @user.id, user: { username: "serendipity" }}
    post :update, json
    assert_equal @user.reload.username, "serendipity"
    assert_response 200
  end

  test "should not update non-existing user for users#update" do
    json = { format: 'json', id: 1, user: { username: "serendipity" }}
    post :update, json
    assert_response 503
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert !response[:error].nil?, "Error should be present"
  end

  test "should not update user with bad params for users#update" do
    json = { format: 'json', id: @user.id, user: { username: "bob" }}
    post :update, json
    assert_response 503
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert !response[:error].nil?, "Error should be present"
  end

end
