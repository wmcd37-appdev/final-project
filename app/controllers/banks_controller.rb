class BanksController < ApplicationController
  def index
    @userlocations = Location.where(user_id: current_user.id)
    @locationarray = Array.new
    @userlocations.each do |userlocation|
     
      @locationarray.push(userlocation.id)
           
    end
    
    @anumber = BankBranch.where(location_id: @locationarray.at(0))
    @brancharray1 = Array.new
    @anumber.each do |branch|
      @brancharray1.push(branch.bank_id)
      @brancharray1 = @brancharray1.uniq
    end
    
    @anumber = BankBranch.where(location_id: @locationarray.at(1))
    @brancharray2 = Array.new
    @anumber.each do |branch|
      @brancharray2.push(branch.bank_id)
      @brancharray2 = @brancharray2.uniq
    end    

    @anumber = BankBranch.where(location_id: @locationarray.at(2))
    @brancharray3 = Array.new
    @anumber.each do |branch|
      @brancharray3.push(branch.bank_id)
      @brancharray3 = @brancharray3.uniq
    end 
    
    @finalbrancharray = Array.new
    @finalbrancharray = @brancharray1 & @brancharray2 & @brancharray3
    
    @finalbrancharray.each do |bank|
      @insturl = "https://odata.fdic.gov/v1/financial-institution/Institution?$format=json&$top=1000&$filter=certNumber%20eq%20%27" + bank.to_s + "%27"
      @parsedinst =JSON.parse(open(@insturl).read)
      @instresults = @parsedinst.fetch("d").fetch("results").at(0).fetch("instFinLegalName")
      @bank = Bank.new
      @bank.bank_name = @instresults
      @bank.fdic_number = bank
      @bank.save
    end
    
    
   
    @banks = Bank.all

    render("bank_templates/index.html.erb")
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
