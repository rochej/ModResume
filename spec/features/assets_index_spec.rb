require 'rails_helper'


RSpec.feature "Assets", type: :feature, js: true, feature: true do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @resume = FactoryGirl.create(:resume)
    @skill = FactoryGirl.create(:skill)
    @tag = FactoryGirl.create(:tag)
    @user.resumes << @resume
    @user.skills << @skill
    @user.tags << @tag
    @skill.tags << @tag
  end

  it 'can see the new assets page' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    click_link "My Assets"
    expect(page).to have_content("Objectives")
    expect(page).to have_content(@skill.title)
  end

  it 'skill disappears when tab is un-clicked' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    click_link "My Assets"
    first('.tag-button').click
    expect(page).to have_no_content(@skill.title)
  end

  it 'navigates to new asset page' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    click_link "My Assets"
    click_on "New Asset"
    expect(page).to have_content("Create a New Asset")
  end

  it 'click on new asset type populates form' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    click_link "My Assets"
    click_on "New Asset"
    click_on "Educations"
    expect(page).to have_content("Institution Name")
  end

  it 'form can be filled out and saved' do
    visit "/"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => 'password'
    click_button "Log in"
    click_link "My Assets"
    click_on "New Asset"
    click_on "Skills"
    fill_in 'Title', :with => "Moon Bounce"
    fill_in 'Add Tags', :with => "Space"
    click_on 'Save'
    expect(page).to have_content("Asset Saved")
    expect(Skill.all.count).to eq(2)
  end

end
