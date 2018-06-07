Rails.application.routes.draw do
  # Routes for the Bank resource:

  # CREATE
  get("/banks/new", { :controller => "banks", :action => "new_form" })
  post("/create_bank", { :controller => "banks", :action => "create_row" })

  # READ
  get("/banks", { :controller => "banks", :action => "index" })
  get("/banks/:id_to_display", { :controller => "banks", :action => "show" })

  # UPDATE
  get("/banks/:prefill_with_id/edit", { :controller => "banks", :action => "edit_form" })
  post("/update_bank/:id_to_modify", { :controller => "banks", :action => "update_row" })

  # DELETE
  get("/delete_bank/:id_to_remove", { :controller => "banks", :action => "destroy_row" })

  #------------------------------

  # Routes for the Bank branch resource:

  # CREATE
  get("/bank_branches/new", { :controller => "bank_branches", :action => "new_form" })
  post("/create_bank_branch", { :controller => "bank_branches", :action => "create_row" })

  # READ
  get("/bank_branches", { :controller => "bank_branches", :action => "index" })
  get("/bank_branches/:id_to_display", { :controller => "bank_branches", :action => "show" })

  # UPDATE
  get("/bank_branches/:prefill_with_id/edit", { :controller => "bank_branches", :action => "edit_form" })
  post("/update_bank_branch/:id_to_modify", { :controller => "bank_branches", :action => "update_row" })

  # DELETE
  get("/delete_bank_branch/:id_to_remove", { :controller => "bank_branches", :action => "destroy_row" })

  #------------------------------

  # Routes for the Zip code resource:

  # CREATE
  get("/zip_codes/new", { :controller => "zip_codes", :action => "new_form" })
  post("/create_zip_code", { :controller => "zip_codes", :action => "create_row" })

  # READ
  get("/zip_codes", { :controller => "zip_codes", :action => "index" })
  get("/zip_codes/:id_to_display", { :controller => "zip_codes", :action => "show" })

  # UPDATE
  get("/zip_codes/:prefill_with_id/edit", { :controller => "zip_codes", :action => "edit_form" })
  post("/update_zip_code/:id_to_modify", { :controller => "zip_codes", :action => "update_row" })

  # DELETE
  get("/delete_zip_code/:id_to_remove", { :controller => "zip_codes", :action => "destroy_row" })

  #------------------------------

  # Routes for the Location resource:

  # CREATE
  get("/locations/new", { :controller => "locations", :action => "new_form" })
  post("/create_location", { :controller => "locations", :action => "create_row" })

  # READ
  get("/locations", { :controller => "locations", :action => "index" })
  get("/locations/:id_to_display", { :controller => "locations", :action => "show" })

  # UPDATE
  get("/locations/:prefill_with_id/edit", { :controller => "locations", :action => "edit_form" })
  post("/update_location/:id_to_modify", { :controller => "locations", :action => "update_row" })

  # DELETE
  get("/delete_location/:id_to_remove", { :controller => "locations", :action => "destroy_row" })


  get("/welcome", { :controller => "locations", :action => "welcome" })
  #------------------------------

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  
root "locations#welcome"
end
