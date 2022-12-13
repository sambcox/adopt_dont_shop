# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

@shelter = Shelter.create({ name: 'Denver Shelter', city: 'Denver, CO', foster_program: true, rank: 5 })

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
@application = Application.create({
                                    name: 'Jeff',
                                    street_address: '123 Main Street',
                                    city: 'Denver',
                                    state: 'CO',
                                    zip_code: 22_314,
                                    reason: 'Nice person'
                                  })
@pet_4 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                  shelter_id: @shelter_1.id)
@pet_5 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter_1.id)
