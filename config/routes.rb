# config/routes.rb
Rails.application.routes.draw do
  # Existing routes
  root({ :controller => "home", :action => "index" })
  get("/home/index", { :controller => "home", :action => "index" })
  
  # Course evaluations routes - ensure specific routes come before parameterized routes
  get("/course_evaluations/search/instructor", { :controller => "course_evaluations", :action => "search_instructor" })
  get("/course_evaluations/compare", { :controller => "course_evaluations", :action => "compare" })
  get("/course_evaluations", { :controller => "course_evaluations", :action => "index" })
  get("/course_evaluations/:id", { :controller => "course_evaluations", :action => "show" })
end
