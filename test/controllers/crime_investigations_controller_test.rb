require "test_helper"

describe CrimeInvestigationsController do
  it "should get new" do
    get crime_investigations_new_url
    value(response).must_be :success?
  end

end
