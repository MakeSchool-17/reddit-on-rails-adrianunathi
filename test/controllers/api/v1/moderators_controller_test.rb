require 'test_helper'

class Api::V1::ModeratorsControllerTest < ActionController::TestCase

  def setup
    @subboard = subboards(:bobs_board)
    @user = users(:james)
    @otheruser = users(:leila)
    @moderator = moderators(:leila_bobs)
  end

  def teardown
    @subboard = nil
    @user = nil
    @otheruser = nil
    @moderator = nil
  end

  test "should get all moderators for moderator#index" do
    json = { format: 'json', name: @subboard.name}
    get :index
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal Moderator.all.length, response["moderators"].length
  end

  test "should create a moderator for moderator#create" do
    json = { format: 'json', username: @user.username,
                                             name: @subboard.name }
    post :create, json
    assert_response 201
  end

  test "should not create moderator with non-existing username for moderator#create" do
    json = { format: 'json', username: "blabla", name: @subboard.name }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 503
  end

  test "should not create moderator with non-existing subboard for moderator#create" do
    json = { format: 'json', username: @user.username, name: "blabla" }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 503
  end

  test "should not create duplicate moderator for moderator#create" do
    json = { format: 'json', username: @otheruser.username, name: @subboard.name }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 500
  end

  test "should delete a moderator for moderator#delete" do
    assert_difference 'Moderator.all.length', -1 do
      post :destroy , username: @otheruser.username
      assert_response 204
    end
  end

  test "should fail delete with non-existing username for moderator#destroy" do
    assert_no_difference 'Moderator.all.length' do
      post :destroy, username: 'blahblah'
      assert_response 503
    end
  end

  test "should fail delete with non-existing moderator for moderator#destroy" do
    assert_no_difference 'Moderator.all.length' do
      post :destroy, username: 'james'
      assert_response 503
    end
  end

end
