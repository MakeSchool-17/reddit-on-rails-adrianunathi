require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase

  def setup
    @subboard = subboards(:bobs_board)
    @user = users(:bob)
    @post = posts(:bobs_post)
  end

  def teardown
    @subboard = nil
    # @user = nil
  end

  test "should get all users for user#index" do
    get :index
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal Post.all.length, response["posts"].length
  end

  test "should create post for post#create" do
    json = { format: 'json', post: { title: "Some title",
                                     content: "Some content",
                                     author_username: @user.username,
                                     subboard_name: @subboard.name } }
    post :create, json
    assert_response 201
  end

  test "should not create post with invalid fields for post#create" do
    json = { format: 'json', post: { title: "Some title",
                                     content: "Some content",
                                     author_username: @user.username,
                                     subboard_name: "bad subboard name" } }
    post :create, json
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
    assert_response 500
  end

  test "should show post for post#show" do
    get :show, id: @post.id
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_response 200
    assert_equal response[:id], @post.id
  end

  test "should not show non-existing post for post#show" do
    get :show, id: 1
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_not response[:error].nil?, "Error should be present"
    assert_response 503
  end

  test "should nullify post for post#destroy" do
    assert_difference 'Post.all.length', -1 do
      post :destroy, id: @post.id
      assert_response 200
    end
  end

  test "should fail delete non-existing subboard for users#destroy" do
    assert_no_difference 'Post.all.length' do
      post :destroy, id: 3
      assert_response 503
    end
  end

end
