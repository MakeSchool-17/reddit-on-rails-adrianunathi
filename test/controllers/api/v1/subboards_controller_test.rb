require 'test_helper'

class Api::V1::SubboardsControllerTest < ActionController::TestCase

  def setup
    @subboard = subboards(:bobs_board)
    @user = users(:bob)
  end

  def teardown
    @subboard = nil
  end

  test "should get all subboard for subboard#index" do
    get :index
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal response["subboards"].length, Subboard.all.length
    # assert_equal response["users"], User.all.as_json
  end

  test "should create subboard for subboard#create" do
    json = { format: 'json', subboard: { name: "aboard", private: false, user_id: @user.id}}
    post :create, json
    assert_response 201
  end

  test "should not create invalid subboard for subboard#create" do
    json = { format: 'json', subboard: { name: "a", private: false}}
    post :create, json
    response = JSON.parse(@response.body)
    assert !response["error"].nil?, "Error should be present"
    assert !response["error"].empty?, "Error messages should be present"
    assert_response 500
  end

  test "should show subboard for subboard#show" do
    get :show, id: @subboard.id
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_equal @subboard.name, response[:name]
    assert_response 200
  end

  test "should not show non-existing subboard for subboard#show" do
    get :show, id: 1
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert !response[:error].nil?, "Error should be present"
    assert_response 503
  end

  test "should delete user for subboard#destroy" do
    assert_difference 'Subboard.all.length', -1 do
      post :destroy, id: @subboard.id
      assert_response 200
    end
  end

  test "should fail delete non-existing subboard for users#destroy" do
    assert_no_difference 'Subboard.all.length' do
      post :destroy, id: 1
      assert_response 503
    end
  end

  test "should update subboard for subboard#update" do
    json = { format: 'json', id: @subboard.id, subboard: { private: true }}
    post :update, json
    assert_equal true, @subboard.reload.private
    assert_response 200
  end

  test "should not update subboard name for subboard#update" do
    json = { format: 'json', id: @subboard.id, subboard: { name: "serendipity" }}
    post :update, json
    assert_equal @subboard.name, @subboard.reload.name
    assert_response 200
  end

  test "should not update non-existing subbboard for subboard#update" do
    json = { format: 'json', id: 1, subboard: { private: false }}
    post :update, json
    assert_response 503
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert !response[:error].nil?, "Error should be present"
  end

  test "should not update user with bad params for users#update" do
    json = { format: 'json', id: @user.id, subboard: { private: true }}
    post :update, json
    assert_response 503
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert !response[:error].nil?, "Error should be present"
  end

end
