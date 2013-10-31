require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @vote = votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votes)
  end

  test "should get new" do
    get :new, poll 1
    assert_response :success
  end

  # test "should create vote" do
  #   assert_difference('Vote.count') do
  #     post :create, vote: { answer_id: @vote.answer_id, browser: @vote.browser, ip: @vote.ip, latitude: @vote.latitude, longitude: @vote.longitude }
  #   end
  # 
  #   assert_redirected_to vote_path(assigns(:vote))
  # end

  test "should show vote" do
    get :show, id: @vote
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @vote
  #   assert_response :success
  # end

  test "should update vote" do
    patch :update, id: @vote, vote: { answer_id: @vote.answer_id, browser: @vote.browser, ip: @vote.ip, latitude: @vote.latitude, longitude: @vote.longitude }
    assert_redirected_to vote_path(assigns(:vote))
  end

  test "should destroy vote" do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: @vote
    end

    assert_redirected_to votes_path
  end
end
