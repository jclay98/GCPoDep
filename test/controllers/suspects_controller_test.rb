require "test_helper"

describe SuspectsController do
  it "should get new" do
    get suspects_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get suspects_edit_url
    value(response).must_be :success?
  end

end
