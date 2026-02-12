Rails.application.routes.draw do
    get("/tacos", :controller => "tacos", :action => "index")
    root "tacos#index"
  
  end
