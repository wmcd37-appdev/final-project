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
    
    @street_address = params.fetch("location_address")
    url_safe_street_address = URI.encode(@street_address)
    @location.location_name = params.fetch("location_name")
    @location.display_address = @street_address
    @location.location_address = url_safe_street_address
    @location.user_id = params.fetch("user_id")
    if params.fetch("inputradius") == "Selected zipcode only"
      @location.searchradius = 0
    elsif params.fetch("inputradius") == "1 km radius"
      @location.searchradius = 1
    else
      @location.searchradius = 2
    end
    require "open-uri"
    completeurl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address + "&key=AIzaSyAqRRVQNLRaJgtIxoOope775l6KRAhmQec"
    parsed_data = JSON.parse(open(completeurl).read)

    # if parsed_data.dig("results") == []
    #   redirect_to("/locations/new", :notice => "Address not valid. Please enter a valid address.")
    # else

    @location.latitude = parsed_data.dig("results", 0, "geometry", "location", "lat")
    @location.longitude = parsed_data.dig("results", 0, "geometry", "location", "lng")
    @location.ziplocation = parsed_data.fetch("results").at(0).fetch("address_components").select {|s| s["types"] == ["postal_code"] }.at(0).fetch("long_name").to_i

    @placesurl = "https://www.zipcodeapi.com/rest/" + ENV["ZIP_KEY"] + "/radius.json/" + @location.ziplocation.to_s + "/" + @location.searchradius.to_s + "/km?minimal"
    @parsed_data2 =JSON.parse(open(@placesurl).read)
    @zip_array = @parsed_data2.fetch("zip_codes")


    if @zip_array.length == 0
      @zip_array.push(@location.ziplocation)
    end
 
    if @location.valid?
     redirect_to("/locations", :notice => "Location created successfully. YES")
     @location.save
      @zip_array.each do |zip|
        @zip = ZipCode.new
        @zip.zip_number = zip
        @zip.location_id = @location.id
        @zip.save
    
        @fdicurl = "https://odata.fdic.gov/v1/financial-institution/Branch?$format=json&$top=100&$filter=zip%20eq%20%27" + @zip.zip_number.to_s + "%27"
        @parsed_data3 =JSON.parse(open(@fdicurl).read)
        @fdicresults = @parsed_data3.fetch("d").fetch("results")
      
        @fdicresults.each do |branch|
          @bank_branch = BankBranch.new
          @bank_branch.bank_id = branch.fetch("certNumber")
          @bank_branch.location_id = @location.id
          @bank_branch.save
        end
      end

    else
     render("/location_templates/new_form")
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
  
  
  def welcome
    

    render("location_templates/welcome.html.erb")
  end  
  
  
  
end
  
  
