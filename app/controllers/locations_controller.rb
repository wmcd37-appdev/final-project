class LocationsController < ApplicationController
  def index
    @locations = Location.all

    render("location_templates/index.html.erb")
  end

  def show
    @location = Location.find(params.fetch("id_to_display"))

    render("location_templates/show.html.erb")
  end

  def new_form
    render("location_templates/new_form.html.erb")
  end

  def create_row
    @location = Location.new

    @location.location_name = params.fetch("location_name")
    @location.location_address = params.fetch("location_address")
    @location.user_id = params.fetch("user_id")

    if @location.valid?
      @location.save

      redirect_to("/locations", :notice => "Location created successfully.")
    else
      render("location_templates/new_form.html.erb")
    end
  end

  def edit_form
    @location = Location.find(params.fetch("prefill_with_id"))

    render("location_templates/edit_form.html.erb")
  end

  def update_row
    @location = Location.find(params.fetch("id_to_modify"))

    @location.location_name = params.fetch("location_name")
    @location.location_address = params.fetch("location_address")
    @location.user_id = params.fetch("user_id")

    if @location.valid?
      @location.save

      redirect_to("/locations/#{@location.id}", :notice => "Location updated successfully.")
    else
      render("location_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @location = Location.find(params.fetch("id_to_remove"))

    @location.destroy

    redirect_to("/locations", :notice => "Location deleted successfully.")
  end
end
