require "rails_helper"

describe "shows/show.html.erb" do
  it "renders a title" do
    show = build_stubbed(:show)
    assign(:show, show)
    render
    expect(rendered).to include show.title
    expect(rendered).to include show.description
    expect(rendered).to include show.image.url
  end
end
