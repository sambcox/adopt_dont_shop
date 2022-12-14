require 'rails_helper'

RSpec.describe 'Admin Shelter Show Page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO',
                                zip_code: 80_014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX',
                                zip_code: 59_235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO',
                                zip_code: 80_220, foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application = Application.create({
                                        name: 'Jeff',
                                        street_address: '123 Main Street',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip_code: 22_314,
                                      })

    @pet_4 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter_1.id)
    @pet_5 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter_1.id)
    visit "/applications/#{@application.id}"
    fill_in('reason', with: 'Nice person')
    click_on "Submit Application"
  end

  it 'shows shelter name and address' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to_not have_content(@shelter_2.name)
    expect(page).to have_content("#{@shelter_1.street_address}, #{@shelter_1.city} #{@shelter_1.zip_code}")
    expect(page).to_not have_content("#{@shelter_2.street_address}, #{@shelter_2.city} #{@shelter_2.zip_code}")
  end

  it 'displays average age of all pets under Statistics section' do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content('Statistics:')
    within('#statistics') do
      expect(page).to have_content('Average age of adoptable pets: 3.5')
    end
  end

  it 'displays count of pets at the shelter' do
    visit "/admin/shelters/#{@shelter_1.id}"
    within('#statistics') do
      expect(page).to have_content('Number of adoptable pets: 4')
    end
  end

  it 'displays number of pets adopted from a shelter' do
    @application.update(status: 'Approved')
    visit "/admin/shelters/#{@shelter_1.id}"
    within('#statistics') do
      expect(page).to have_content('Number of pets adopted: 2')
    end
  end

  it 'displays a list of applications that require attention' do
    @pet_4.application_pets.first.update(pet_status: 'Approved')
    visit "/admin/shelters/#{@shelter_1.id}"
    within('#action_required') do
      expect(page).to_not have_content('Lucille Bald')
      expect(page).to have_content('Dogmin')
    end
  end

  it 'displays a link next to each pet that requires attention that links to the application show page' do
    visit "/admin/shelters/#{@shelter_1.id}"
    within('#action_required') do
      first(:link, 'Application Page').click
      expect(current_path).to eq("/admin/applications/#{@application.id}")
    end
  end
end
