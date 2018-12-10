require "test_helper"

describe InvestigationNotesController do
  it "should get new" do
    get investigation_notes_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get investigation_notes_edit_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get investigation_notes_destroy_url
    value(response).must_be :success?
  end

end
