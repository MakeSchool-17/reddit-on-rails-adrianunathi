require 'test_helper'

class ManagingSubboardsAndPostsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @bob = users(:bob)
  end

  test "should create subboards for valid user" do
    post api_subboards_path, { format: 'json', subboard: { name: "aboard", private: false, user_id: @bob.id}}
    assert_equal 201, @response.status
    response = JSON.parse(@response.body, { symbolize_names: true })
    assert_equal "testing", response["name"]
  end


end
