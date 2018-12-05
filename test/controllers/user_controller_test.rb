require "test_helper"

describe UserController do
  it "should get index" do
    get user_index_url
    value(response).must_be :success?
  end

  it "should get new" do
    get user_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get user_edit_url
    value(response).must_be :success?
  end

end
