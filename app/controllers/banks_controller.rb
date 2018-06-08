class BanksController < ApplicationController
  def index
    Bank.delete_all
      @userlocations = Location.where(user_id: current_user.id)
      if @userlocations.length == 0
        redirect_to("/locations/", :notice => "You have not selected any locations. Please add locations before continuing to the banks page.")
      else
      @locationarray = Array.new
      @userlocations.each do |userlocation|
        @locationarray.push(userlocation.id)
      end
    @finalbrancharray = Array.new  
    @locationarray.each do |location|
      @anumber = BankBranch.where(location_id: location)
      @brancharray = Array.new
      @anumber.each do |branch|
        @brancharray.push(branch.bank_id)
        @brancharray = @brancharray.uniq
      end
     
      @finalbrancharray.push(@brancharray)
       
    end
      @finalbrancharray = @finalbrancharray.inject(&:&)
                

    @finalbrancharray.each do |bank|
      @insturl = "https://odata.fdic.gov/v1/financial-institution/Institution?$format=json&$top=1000&$filter=certNumber%20eq%20%27" + bank.to_s + "%27"
      @parsedinst =JSON.parse(open(@insturl).read)
      @instresults = @parsedinst.fetch("d").fetch("results").at(0).fetch("instFinLegalName")

      @bank = Bank.new
     @bank.total_deposits = @parsedinst.fetch("d").fetch("results").at(0).fetch("totalDeposits")
     @bank.website_address = @parsedinst.fetch("d").fetch("results").at(0).fetch("webSite")
     @bank.total_assets = @parsedinst.fetch("d").fetch("results").at(0).fetch("totalAssets")
     @bank.date_established = @parsedinst.fetch("d").fetch("results").at(0).fetch("establishedDate")
     @bank.fdic_active = @parsedinst.fetch("d").fetch("results").at(0).fetch("active")
      @bank.bank_name = @instresults
      @bank.fdic_number = bank
      
      if @bank.valid?
      @bank.save
    else
      redirect_to("/locations/", :notice => "Bank determination failed. Please try again or contact the administrator.")
    end
    end
    
    
   
    @banks = Bank.all

    render("bank_templates/index.html.erb")
  end
  end

  def show
    @bank = Bank.find(params.fetch("id_to_display"))

    render("bank_templates/show.html.erb")
  end

  def new_form
    render("bank_templates/new_form.html.erb")
  end

  def create_row
    @bank = Bank.new

    @bank.bank_name = params.fetch("bank_name")
    @bank.website_address = params.fetch("website_address")
    @bank.total_deposits = params.fetch("total_deposits")
    @bank.fdic_number = params.fetch("fdic_number")
    @bank.fdic_active = params.fetch("fdic_active")

    if @bank.valid?
      @bank.save

      redirect_to("/banks", :notice => "Bank created successfully.")
    else
      render("bank_templates/new_form.html.erb")
    end
  end

  def edit_form
    @bank = Bank.find(params.fetch("prefill_with_id"))

    render("bank_templates/edit_form.html.erb")
  end

  def update_row
    @bank = Bank.find(params.fetch("id_to_modify"))

    @bank.bank_name = params.fetch("bank_name")
    @bank.website_address = params.fetch("website_address")
    @bank.total_deposits = params.fetch("total_deposits")
    @bank.fdic_number = params.fetch("fdic_number")
    @bank.fdic_active = params.fetch("fdic_active")

    if @bank.valid?
      @bank.save

      redirect_to("/banks/#{@bank.id}", :notice => "Bank updated successfully.")
    else
      render("bank_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @bank = Bank.find(params.fetch("id_to_remove"))

    @bank.destroy

    redirect_to("/banks", :notice => "Bank deleted successfully.")
  end
end
