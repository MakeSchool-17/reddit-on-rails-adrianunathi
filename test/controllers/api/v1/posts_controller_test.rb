require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase

  def setup
    @subboard = subboards(:bobs_board)
    @user = users(:bob)
    @post = posts(:bobs_post)
  end

  def teardown
    @subboard = nil
    @user = nil
    @post = nil
  end

  test "should get all posts for post#index" do
    json = { format: 'json', name: @subboard.name}
    get :index, json
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal @subboard.posts.length, response["posts"].length
  end

  test "should create post for post#create" do
    json = { format: 'json', title: "Some title",
                                     content: "Some content",
                                     author_username: @user.username,
                                     subboard_name: @subboard.name }
    post :create, json
    assert_response 201
  end

  test "should not create post with invalid fields for post#create" do
    json = { format: 'json', title: "Some title",
                                     content: "Some content",
                                     author_username: @user.username,
                                     subboard_name: "bad subboard name" }
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
    post :destroy, id: @post.id
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_not response[:active]
    assert_not @post.reload.active
    assert_response 200
  end

  test "should fail nullifying non-existing post for post#destroy" do
    assert_no_difference 'Post.all.length' do
      post :destroy, id: 3
      assert_response 503
      response = JSON.parse(@response.body, { symbolize_names: true })
      assert_not response[:error].nil?, "Error should be present"
    end
  end

end
