require 'test_helper'

module Discussion
  class ThreadsControllerTest < ActionController::TestCase
    setup do
      @thread = threads(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:threads)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create thread" do
      assert_difference('Thread.count') do
        post :create, thread: { initiator_id: @thread.initiator_id, subject: @thread.subject }
      end
  
      assert_redirected_to thread_path(assigns(:thread))
    end
  
    test "should show thread" do
      get :show, id: @thread
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @thread
      assert_response :success
    end
  
    test "should update thread" do
      put :update, id: @thread, thread: { initiator_id: @thread.initiator_id, subject: @thread.subject }
      assert_redirected_to thread_path(assigns(:thread))
    end
  
    test "should destroy thread" do
      assert_difference('Thread.count', -1) do
        delete :destroy, id: @thread
      end
  
      assert_redirected_to threads_path
    end
  end
end
