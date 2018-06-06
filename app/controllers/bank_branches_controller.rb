class BankBranchesController < ApplicationController
  def index
    @bank_branches = BankBranch.all

    render("bank_branch_templates/index.html.erb")
  end

  def show
    @bank_branch = BankBranch.find(params.fetch("id_to_display"))

    render("bank_branch_templates/show.html.erb")
  end

  def new_form
    render("bank_branch_templates/new_form.html.erb")
  end

  def create_row
    @bank_branch = BankBranch.new

    @bank_branch.bank_branch_name = params.fetch("bank_branch_name")
    @bank_branch.bank_branch_address = params.fetch("bank_branch_address")
    @bank_branch.bank_id = params.fetch("bank_id")

    if @bank_branch.valid?
      @bank_branch.save

      redirect_to("/bank_branches", :notice => "Bank branch created successfully.")
    else
      render("bank_branch_templates/new_form.html.erb")
    end
  end

  def edit_form
    @bank_branch = BankBranch.find(params.fetch("prefill_with_id"))

    render("bank_branch_templates/edit_form.html.erb")
  end

  def update_row
    @bank_branch = BankBranch.find(params.fetch("id_to_modify"))

    @bank_branch.bank_branch_name = params.fetch("bank_branch_name")
    @bank_branch.bank_branch_address = params.fetch("bank_branch_address")
    @bank_branch.bank_id = params.fetch("bank_id")

    if @bank_branch.valid?
      @bank_branch.save

      redirect_to("/bank_branches/#{@bank_branch.id}", :notice => "Bank branch updated successfully.")
    else
      render("bank_branch_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @bank_branch = BankBranch.find(params.fetch("id_to_remove"))

    @bank_branch.destroy

    redirect_to("/bank_branches", :notice => "Bank branch deleted successfully.")
  end
end
