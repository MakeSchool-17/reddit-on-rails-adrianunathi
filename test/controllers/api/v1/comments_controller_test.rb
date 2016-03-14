require 'test_helper'

class Api::V1::CommentsControllerTest < ActionController::TestCase
  def setup
    @user = users(:bob)
    @post = posts(:bobs_post)
    @comment = comments(:first_comment)
  end

  def teardown
    @post = nil
    @user = nil
    @comment = nil
  end

  test "should get all comments for comments#index" do
    json = { format: 'json', parent_id: @post.id, parent_type: 'posts'}
    get :index, json
    assert_response 200
    response = JSON.parse(@response.body)
    assert_equal @post.comments.length, response["comments"].length
  end

  #TODO: Remove author_username from creating
  test "should create comment for comments#create" do
    json = { format: 'json', content: "Some content",
                                      author_username: @user.username,
                                      parent_id: @post.id,
                                      parent_type: 'Post'}
    post :create, json
    assert_response 201
  end

  test "should create comment with comment parent for comments#create" do
    json = { format: 'json', content: "Some content",
                                        author_username: @user.username,
                                        parent_id: @comment.id,
                                        parent_type: 'Comment'}
    post :create, json
    assert_response 201
  end

  test "should not create comment with invalid params for comments#create" do
    json = { format: 'json', content: "Some content",
                                        author_username: @user.username,
                                        parent_id: @post.id,
                                        parent_type: ''}
    post :create, json
    assert_response 500
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
  end

  test "should not create comment with invalid user for comments#create" do
    json = { format: 'json', content: "Some content",
                                        author_username: "username",
                                        parent_id: @post.id,
                                        parent_type: ''}
    post :create, json
    assert_response 500
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
  end

  test "should not create empty contentfor comments#create" do
    json = { format: 'json', content: '',
                                        author_username: @user.username,
                                        parent_id: @post.id,
                                        parent_type: 'Post'}
    post :create, json
    assert_response 500
    response = JSON.parse(@response.body)
    assert_not response["error"].nil?, "Error should be present"
    assert_not response["error"].empty?, "Error messages should be present"
  end

  test "should show comment for comment#show" do
    get :show, id: @comment.id
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_response 200
    assert_equal response[:id], @comment.id
  end

  test "should not show non-existing comment for comment#show" do
    get :show, id: 1
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_not response[:error].nil?, "Error should be present"
    assert_response 503
  end

  test "should nullify comment for comment#destroy" do
    post :destroy, id: @comment.id
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_not response[:active]
    assert_not @comment.reload.active
    assert_response 200
  end

  test "should fail nullifying non-existing post for post#destroy" do
    assert_no_difference 'Comment.all.length' do
      post :destroy, id: 1
      assert_response 503
      response = JSON.parse(@response.body, { symbolize_names: true })
      assert_not response[:error].nil?, "Error should be present"
    end
  end

end
