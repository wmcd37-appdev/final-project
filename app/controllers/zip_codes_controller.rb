class ZipCodesController < ApplicationController
  def index
    @zip_codes = ZipCode.all

    render("zip_code_templates/index.html.erb")
  end

  def show
    @zip_code = ZipCode.find(params.fetch("id_to_display"))

    render("zip_code_templates/show.html.erb")
  end

  def new_form
    render("zip_code_templates/new_form.html.erb")
  end

  def create_row
    @zip_code = ZipCode.new

    @zip_code.zip_number = params.fetch("zip_number")
    @zip_code.location_id = params.fetch("location_id")

    if @zip_code.valid?
      @zip_code.save

      redirect_to("/zip_codes", :notice => "Zip code created successfully.")
    else
      render("zip_code_templates/new_form.html.erb")
    end
  end

  def edit_form
    @zip_code = ZipCode.find(params.fetch("prefill_with_id"))

    render("zip_code_templates/edit_form.html.erb")
  end

  def update_row
    @zip_code = ZipCode.find(params.fetch("id_to_modify"))

    @zip_code.zip_number = params.fetch("zip_number")
    @zip_code.location_id = params.fetch("location_id")

    if @zip_code.valid?
      @zip_code.save

      redirect_to("/zip_codes/#{@zip_code.id}", :notice => "Zip code updated successfully.")
    else
      render("zip_code_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @zip_code = ZipCode.find(params.fetch("id_to_remove"))

    @zip_code.destroy

    redirect_to("/zip_codes", :notice => "Zip code deleted successfully.")
  end
end
