Rails.application.routes.draw do

  # Routes for the Article resource:

    # CREATE
    post("/insert_article", { :controller => "articles", :action => "create" })
            
    # READ
    get("/my_articles", { :controller => "articles", :action => "index" })
    
    get("/articles/:path_id", { :controller => "articles", :action => "show" })
    
    # UPDATE
    
    post("/modify_article/:path_id", { :controller => "articles", :action => "update" })
    
    # DELETE
    get("/delete_article/:path_id", { :controller => "articles", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

    # SIGN UP FORM
    get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
    # CREATE RECORD
    post("/insert_user", { :controller => "user_authentication", :action => "create"  })
        
    # EDIT PROFILE FORM        
    get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
    # UPDATE RECORD
    post("/modify_user", { :controller => "user_authentication", :action => "update" })
    
    # DELETE RECORD
    get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

    # ------------------------------

    # SIGN IN FORM
    get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
    # AUTHENTICATE AND STORE COOKIE
    post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
    
    # SIGN OUT        
    get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
              
  #------------------------------

  # Misc routes:

    get("/", controller: "application", action: "homepage")

  #------------------------------

end
