require 'test_helper'

class SubboardTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @subboard = @user.subboards.build(name: "NewBoard", private: false)
  end

  test "should be valid" do
    assert @subboard.valid?
  end

  test "subboard name should be present" do
    @subboard.name = nil
    assert_not @subboard.valid?
  end

  test "name sould not be too long" do
    @subboard.name = "a"*31
    assert_not @subboard.valid?
  end

  test "name should not be too short" do
    @subboard.name = "aa"
    assert_not @subboard.valid?
  end

  test "name should be saved lowercase" do
    mixed_case_name = "MiXeDCaSeNaMe"
    @subboard.name = mixed_case_name
    @subboard.save
    assert_equal mixed_case_name.downcase, @subboard.reload.name
  end

  test "name should remove white spaces on save" do
    name_with_space = "name with space"
    @subboard.name = name_with_space
    @subboard.save
    assert_equal "namewithspace", @subboard.reload.name
    assert @subboard.valid?
  end

  test "name should be unique" do
    duplicate_board = @subboard.dup
    @subboard.save
    assert_not duplicate_board.valid?
  end

  test "private should be set" do
    @subboard.private = nil
    assert_not @subboard.valid?
  end

  test "order should be most recent first" do
    assert_equal subboards(:most_recent), Subboard.first
  end

end
