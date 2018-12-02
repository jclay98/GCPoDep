require "test_helper"

describe HomeController do
  it "should get index" do
    get home_path
    value(response).must_be :success?
  end

  it "should get about" do
    get about_path
    value(response).must_be :success?
  end

  it "should get contact" do
    get contact_path
    value(response).must_be :success?
  end

  it "should get privacy" do
    get privacy_path
    value(response).must_be :success?
  end

  it "should get search" do
    get search_path
    value(response).must_be :success?
  end

end
