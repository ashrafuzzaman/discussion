require 'spec_helper'

describe "assignments/new" do
  before(:each) do
    assign(:assignment, stub_model(Assignment,
      :title => "MyString",
      :description => "MyString",
      :text => "MyString"
    ).as_new_record)
  end

  it "renders new assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", assignments_path, "post" do
      assert_select "input#assignment_title[name=?]", "assignment[title]"
      assert_select "input#assignment_description[name=?]", "assignment[description]"
      assert_select "input#assignment_text[name=?]", "assignment[text]"
    end
  end
end
