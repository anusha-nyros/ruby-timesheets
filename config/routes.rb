 Timesheets::Application.routes.draw do
  

  resources :invoices do
    collection do
      match 'search' => 'invoices#search', :via => [:get, :post], :as => :search
    end
  end
 match '/invoice_' => "invoices#index"  
 match 'generate_invoice_as_pdf' => 'invoices#generate_invoice_as_pdf'
post '/invoices/send_email' => 'invoices#send_email'
post 'send_email' => 'invoices#send_email' 
  post '/mailform' => "invoices#mailform"  
  match '/invoices/:id/inv' => "invoices#del" ,:as => :inv_line_item_delete
  match '/invoices/:id/editinv' => "invoices#ed" ,:as => :inv_line_item_edit
  match '/invoices/:id/update_inv' => "invoices#update_inv_line_item"


resources :account_histories do
    collection do
    	match 'balance_summaray' => 'account_histories#balance_summary', :as=> :balance_summary
    end
end


  resources :invitations
  resources :creditcards

  resources :expensetypes

  resources :projecttypes

  resources :issuetypes

  resources :tasktypes

  resources :pages

  resources :orgtabs
  resources :skills
  resources :groups

  resources :downloads
  #resources :expenses
  match "expenses/status/:id" => "expenses#status"
  match '/expenses/:id/payment' => "expenses#del" ,:as => :payment_delete
  match '/expenses/:id/editpayment' => "expenses#ed" ,:as => :payment_edit
  match '/expenses/:id/update_payment' => "expenses#update_payment"

  post '/maillist' => "projects#maillist"
  post '/projects/email_tasks' => 'projects#email_tasks'
  post '/project_types/email_projects' => "project_types#email_projects"
  post '/projectmaillist'=> 'project_types#maillist'
  
  post '/projects/update_individual' => 'projects#update_individual'
  post '/update_individual' => "projects#update_individual"
  post '/bulklist' => "projects#bulklist"

  post '/issuemaillist' => 'issues#maillist'
  post '/issues/email_issues' => 'issues#email_issues'

  post '/timerec_maillist' => 'time_records_search#maillist'
  post '/time_records_search/timerecords_mail' => 'time_records_search#timerecords_mail'

  post '/time_maillist' => 'time_records#maillist'
  post '/time_records/mail_time_records' => 'time_records#mail_time_records'
 
  post '/pjrecap_maillist' => 'time_records#pjrecap'
  post '/time_records/project_recap_mail' => 'time_records#project_recap_mail'
 
  post '/usrecap_maillist' => 'time_records#usrecap'
  post '/time_records/user_recap_mail' => 'time_records#user_recap_mail'


  post '/status_maillist' => 'statusreports#maillist'
  post '/statusreports/resend_mail' => 'statusreports#resend_mail'
  
  post '/show_maillist' => 'statusreports#show_maillist'
  
  
  
  

 #for transaction emails
 post "sendmail" => "issues#sendmail"
 post "timerecords_mail" => "time_records_search#timerecords_mail"
 post "expense_mail" => "expenses#expense_mail"

#for creditcard
  match "creditcards_" => "admin/users#creditcards"
  match "upgrade_plans" => "admin/users#upgrade_plans"



 #for selcect box in pagination	
 match '/project_' => 'projects#index'
 match '/my_thread_'=> 'my_threads#index'
 match '/estimateactual' => "projects#estimate_actual"
 match '/statusview' =>"projects#status_view"
 match '/startend' => "projects#start_end"
 match '/expense_' => "expenses#index"
 match '/project_types_' => "project_types#index"

 match '/issue_' => "issues#index"
 match '/contact_' => "contacts#index"
 match '/show_clients' => "contacts#show_clients"
 match '/show_suppliers' => "contacts#show_suppliers"
 match '/timerecords_' => "time_records_search#all_time"
 #analytics

 match "statistics" => "statistics#statistics"
 match 'statistics/search' => 'statistics#search' ,:as => :search_statistics 

 #links/url
  match "/image_view" => "admin/links#image_view"
  #match "/link_state" => "admin/links#index"
  match "/admin/links/sharebox/:id" => "admin/links#sharebox" 
 
 #ajax calls
 match "/show_tasks",  :controller => "issues", :action => "show_category", :as => :get
   match "/show_tasks_edit",  :controller => "issues", :action => "show_category_edit", :as => :get
   match 'issues/status/:id' => 'issues#status'
   match '/users/preference_edit/:id' => 'users#preference_edit' ,:as => :preference_edit
   match '/users/preferences' => 'users#preferences' ,:as => :preference


  resources :calendars
  match '/calendar_view' => 'calendars#view'
  match '/team_view' => 'calendars#team_view'
  match "statistics" => "projects#statistics"
 match "activities/download/:id" => "activities#download"
resources :thread_comments
 resources :link_accounts
  resources :password_resets
  get 'logout' => 'sessions#destroy', :as => "logout"
  get 'login' => 'sessions#new', :as=> "login"
  get 'signup' => 'users#new', :as => "signup"
  get 'account' => 'users#edit', :as => "account"
resources :users do
  member do
    get :activate
  end
end
  
#super admin
  match "superadmin" => "admin/users#superadmin_index"
  match "super_home" => "admin/users#super_home"
  match "users_edit/:id" => "admin/users#users_edit"
  match "sup_edit/:id" => "admin/users#sup_edit"
  
#for switches 
get  "/switches"=>"switch#switches"
post  "switches"=>"switch#switches"
match "switch/status/:id" => "switch#status"


  namespace :admin do
    resources :users, :except =>[:show]
    resources :pay_periods, :except => [:show]
    
    get "reports" => 'report#index', :as => "reports"
    get "reports/:pay_period_id" => 'report#show', :as => "report"
    get "reports/details/:pay_period_id"  => 'report#details', :as => "report_details"
	
	#ozzcat routes
    resources :folders, except: [:show] do
      collection { post :sort }
    end
    
    resources :links, only: [:index] do
      collection do
        get :edit
        put :update
      end
    end

    resources :links do
    collection do
      match 'search' => 'links#search', :via => [:get, :post], :as => :search

    end
   end
   
    match "search_issue" => 'home#search_issue', :via => [:get, :post], :as => :search
    match 'search_task' => 'home#search_task' , :via => [:get, :post], :as => :search
	#ozzcat routes

    root :to => "home#index"  
  end

# for expenses search
resources :expenses do
    collection do
      match 'search' => 'expenses#search', :via => [:get, :post], :as => :search

    end
   end


resources :issues do
    collection do
      match 'search' => 'issues#search', :via => [:get, :post], :as => :search

    end
   end



  resources :contacts do
    collection do
      match 'search' => 'contacts#search', :via => [:get, :post], :as => :search

    end
   end

  resources :meetings do
    collection do
      match 'search' => 'meetings#search', :via => [:get, :post], :as => :search

    end
   end
  resources :statusreports do
    collection do
      match 'search' => 'statusreports#search', :via => [:get, :post], :as => :search

    end
  end
  
  resources :my_threads do
    collection do
      match 'search' => 'my_threads#search', :via => [:get, :post], :as => :search

    end
  end  
  
  resources :my_threads do
    resources :thread_comments
  end

  resources :projects do
    collection do
      match 'search' => 'projects#search', :via => [:get, :post], :as => :search
      match 'searche' => 'projects#searche', :via => [:get, :post], :as => :searche
      match 'search1' => 'projects#search1', :via => [:get, :post], :as => :search1
      match 'esearch' => 'projects#esearch', :via => [:get, :post], :as => :esearch
      match 'start_end_search' => 'projects#start_end_search',:via => [:get, :post], :as => :start_end_search
    end
   end
  resources :users, :only=> [:create, :edit, :update]
  resources :time_records
  resources :sessions, :only=> [:new, :create, :destroy]
   resources :projects do
  resources :comments 
  end
  resources :comments 
  resources :contacts
  resources :timecodes
  resources :statuses

  resources :project_types do
    collection do
        match 'search' => 'project_types#search', :via => [:get, :post], :as => :search
    end
  end

  resources :attendees
 match "project_types/status/:id" => "project_types#status"
  match "project_types/taskstatus/:id" => "project_types#taskstatus"
  
 match 'projects/time_rec/:id' => 'projects#time_rec'
  match "projects/status/:id" => "projects#status"
  match "time_records/status/:id" => "time_records#status"
  root :to => "home#index"  
  #for time records detailed
   match '/view' => 'time_records#view'
   match '/expand' => 'projects#expand'
   get "/user_recap/:pay_period_id" => "time_records#user_recap", :as => "user_recap"
   get "/project_recap/:pay_period_id" => "time_records#project_recap", :as => "project_recap"
   match '/view/:id' => 'time_records#view'
      post "/mail_time_records/:id" =>"time_records#mail_time_records" #format1
   post "user_recap_mail/:pay_period_id" => "time_records#user_recap_mail" #format2
   post "project_recap_mail/:pay_period_id" => "time_records#project_recap_mail" #format3
  #################
 resources :time_records do
    collection do
      match 'search' => 'time_records#search', :via => [:get, :post], :as => :search
    end
   end 

 resources :time_records_search do
    collection do
      match 'all_time' => 'time_records_search#all_time'
    end
   end
post "email_tasks" => "projects#email_tasks"
post "email_projects" => "project_types#email_projects"
 match '/TimeRecords' => 'time_records_search#all_time'
 match '/TimeRecords/search' => 'time_records_search#search'
 get "/estimate_actual" => "projects#estimate_actual"
 get "/status_view" => "projects#status_view"
get "/start_end_view" => "projects#start_end"
 post "delete_check"=>"projects#delete_check"
post "resend_mail" => "statusreports#resend_mail"
get 'easy_import_new' =>'projects#easy_import_new'
post 'easy_import' =>'projects#easy_import'
post "new_lineitems" => "statusreports#new_lineitems"
post "update_lineitems" => "statusreports#update_lineitems"
get "custom_new" => "sessions#custom_new"
post "new_request" => "link_accounts#new_request"
match 'sessions/custom_new/:id' => "sessions#custom_new" ,:as => :custom_new
match 'link_accounts/accept' => 'link_accounts#accept_request'
match 'link_accounts/unlink' => 'link_accounts#unlink'
get "/analytics" => "expenses#analytics" # for analytics 
post 'project_types/stat' => 'project_types#stat'
post "mail_time_records" => "time_records#mail_time_records" #format1
post "user_recap_mail" => "time_records#user_recap_mail" #format2 
post "project_recap_mail" => "time_records#project_recap_mail" #format3

get "bulk_creation_new" => "projects#bulk_creation_new"
post "bulk_creation_preview" => 'projects#bulk_creation_preview'
post 'bulk_creation' =>'projects#bulk_creation'


get 'bulkissues_new' => 'issues#bulkissues_new'
post 'bulkissues_preview' => 'issues#bulkissues_preview'
post 'bulkissues_creation' => 'issues#bulkissues_creation'

#####for project pdf report
 post "pdf_report"=>"projects#pdf_report"
 #get  "pdf_report"=>"projects#pdf_report"
#for static pages

  match '/privacy' => 'pages#privacy'
  match '/contact_us' => 'pages#new'
  match '/legal'=> 'pages#legal'
  match '/pricing' => 'pages#pricing'

# for budget views 
get "/budget_view" => "project_types#budget_view"
get "/over_budget_view" => "project_types#over_budget_view"

#ozzct routes
  
 resources :categories  
  resources :activities do
    collection do
      match 'search' => 'activities#search', :via => [:get, :post], :as => :search
    end
    resources :attachments, only: [:create, :destroy]
  end

get '/:url'  => 'links#show', :constraints => {:url => /[a-zA-Z_#]+/}

end
