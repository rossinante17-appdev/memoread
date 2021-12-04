Rails.application.routes.draw do

  get("/test", controller: "application", action: "twilio_test")

  # Routes for the Summary resource:

    # CREATE
    post("/insert_summary", { :controller => "summaries", :action => "create" })
            
    # READ
    get("/summaries", { :controller => "summaries", :action => "index" })
    
    get("/summaries/:path_id", { :controller => "summaries", :action => "show" })
    
    # UPDATE
    
    post("/modify_summary/:path_id", { :controller => "summaries", :action => "update" })
    
    # DELETE
    get("/delete_summary/:path_id", { :controller => "summaries", :action => "destroy" })             

  #------------------------------

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

    # Text the article
    get("/text_article", controller: "articles", :action => "send_text")

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

  # Impression routes
    
      # LINK OUT
      get("/link/:path_id", controller: "impressions", action: "link_out")

  #------------------------------

  # Misc routes:

    get("/", controller: "application", action: "homepage")

  #------------------------------

end
