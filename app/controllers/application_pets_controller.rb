class ApplicationPetsController < ApplicationController
  def create
    application_pet = ApplicationPet.new(application_pet_params)
    application_pet.save
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    application_pet = ApplicationPet.find_application_pet(params[:application_id], params[:pet_id])

    application_pet.update(application_pet_params)
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  private

  def application_pet_params
    params.permit(:application_id, :pet_id, :pet_status)
  end
end
