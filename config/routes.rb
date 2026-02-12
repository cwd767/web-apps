Rails.application.routes.draw do
  get("/tacos", :controller => "tacos", :action => "index")
end
