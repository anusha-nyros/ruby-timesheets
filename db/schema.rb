# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130806051128) do

  create_table "account_histories", :force => true do |t|
    t.date     "date"
    t.string   "num_invoice"
    t.text     "description"
    t.string   "type_of_account"
    t.string   "reference"
    t.string   "statement_attachment"
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "assign_to"
    t.decimal  "amount",               :precision => 20, :scale => 5
    t.decimal  "balance",              :precision => 20, :scale => 5
  end

  create_table "activities", :force => true do |t|
    t.date     "date"
    t.text     "info"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "tags"
    t.string   "attachment"
    t.integer  "attachments_count", :default => 0
    t.string   "priority"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "doc_check",         :default => false
  end

  add_index "activities", ["category_id"], :name => "index_activities_on_category_id"
  add_index "activities", ["date"], :name => "index_activities_on_date"
  add_index "activities", ["organization_id"], :name => "index_activities_on_organization_id"
  add_index "activities", ["priority"], :name => "index_activities_on_priority"
  add_index "activities", ["tags"], :name => "index_activities_on_tags"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "attachments", :force => true do |t|
    t.string   "doc"
    t.integer  "project_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "content_type"
  end

  create_table "attendees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
  end

  create_table "attendees_meetings", :id => false, :force => true do |t|
    t.integer "attendee_id"
    t.integer "meeting_id"
  end

  create_table "calendars", :force => true do |t|
    t.date     "entry_date"
    t.string   "event"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "cal_num"
    t.text     "activity"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "organization_id"
    t.string   "color"
    t.string   "group"
    t.integer  "folder_id"
    t.boolean  "use_privacy",     :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "categories", ["color"], :name => "index_categories_on_color"
  add_index "categories", ["folder_id"], :name => "index_categories_on_folder_id"
  add_index "categories", ["group"], :name => "index_categories_on_group"
  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["organization_id"], :name => "index_categories_on_organization_id"
  add_index "categories", ["slug"], :name => "index_categories_on_slug"
  add_index "categories", ["use_privacy"], :name => "index_categories_on_use_privacy"

  create_table "categories_users", :force => true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories_users", ["category_id"], :name => "index_categories_users_on_category_id"
  add_index "categories_users", ["user_id"], :name => "index_categories_users_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "coment"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uname"
  end

  create_table "contacts", :force => true do |t|
    t.string   "contact_type",    :default => "contact"
    t.string   "contact"
    t.string   "company"
    t.string   "email"
    t.string   "chat_tool"
    t.integer  "user_id"
    t.boolean  "active"
    t.text     "notes"
    t.integer  "organization_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "photo"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "fb"
    t.string   "linkedin"
    t.string   "address"
    t.string   "mobile_phone"
    t.string   "skype"
  end

  add_index "contacts", ["contact_type"], :name => "index_contacts_on_contact_type"
  add_index "contacts", ["organization_id"], :name => "index_contacts_on_organization_id"
  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "contacts_groups", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "group_id"
  end

  create_table "contacts_project_types", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "project_type_id"
  end

  create_table "contacts_skills", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "skill_id"
  end

  create_table "creditcards", :force => true do |t|
    t.integer  "number",          :limit => 8
    t.date     "expiryon"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "downloads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "expense_attachments", :force => true do |t|
    t.string   "doc"
    t.integer  "expense_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "expenses", :force => true do |t|
    t.string   "exp_number"
    t.string   "username"
    t.date     "date"
    t.decimal  "amount",             :precision => 10, :scale => 1, :default => 0.0
    t.boolean  "status"
    t.date     "approved_date"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.string   "expense_type"
    t.string   "contact_type"
    t.string   "reference"
    t.integer  "expensetype_id"
    t.decimal  "total_approved_amt", :precision => 10, :scale => 1, :default => 0.0
    t.decimal  "paid_expense_amt",   :precision => 10, :scale => 1, :default => 0.0
  end

  create_table "expensetypes", :force => true do |t|
    t.string   "expensetype"
    t.text     "usage"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.string   "slug"
    t.integer  "position"
    t.boolean  "use_privacy",     :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "folders", ["name"], :name => "index_folders_on_name"
  add_index "folders", ["organization_id"], :name => "index_folders_on_organization_id"
  add_index "folders", ["position"], :name => "index_folders_on_position"
  add_index "folders", ["slug"], :name => "index_folders_on_slug"
  add_index "folders", ["use_privacy"], :name => "index_folders_on_use_privacy"

  create_table "folders_users", :force => true do |t|
    t.integer "folder_id"
    t.integer "user_id"
  end

  add_index "folders_users", ["folder_id"], :name => "index_folders_users_on_folder_id"
  add_index "folders_users", ["user_id"], :name => "index_folders_users_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "title"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "inv_line_items", :force => true do |t|
    t.string   "reference"
    t.text     "description"
    t.string   "quantity"
    t.string   "unit"
    t.integer  "amount"
    t.string   "extended"
    t.text     "text_comment"
    t.integer  "invoice_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "invitations", :force => true do |t|
    t.string   "username"
    t.text     "description"
    t.string   "send_to"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "invoices", :force => true do |t|
    t.string   "invoice"
    t.date     "date"
    t.string   "client"
    t.string   "reference"
    t.integer  "amount"
    t.boolean  "paid"
    t.integer  "balance"
    t.date     "last_payment"
    t.string   "days_old"
    t.string   "aging"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "issueattachments", :force => true do |t|
    t.string   "issue_attach"
    t.integer  "issue_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "issues", :force => true do |t|
    t.string   "title"
    t.integer  "issuetype_id"
    t.integer  "project_type_id"
    t.integer  "project_id"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.date     "date_created"
    t.string   "owner"
    t.string   "issue_number"
  end

  create_table "issuetypes", :force => true do |t|
    t.string   "issuetype"
    t.text     "usage"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "line_items", :force => true do |t|
    t.string   "status_details"
    t.string   "per_completed"
    t.integer  "statusreport_id"
    t.integer  "project_id"
    t.string   "project_type"
    t.string   "title"
    t.text     "notes"
    t.string   "prq_number"
    t.string   "action_required"
    t.string   "priority"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.date     "schedule_date"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "status_date"
    t.string   "entered_by"
    t.string   "reference"
    t.string   "owner"
    t.decimal  "amount",           :precision => 10, :scale => 1
    t.decimal  "variance",         :precision => 10, :scale => 1
    t.decimal  "percent_variance", :precision => 10, :scale => 1
    t.decimal  "actual",           :precision => 10, :scale => 1
    t.integer  "contact_id"
    t.integer  "organization_id"
  end

  create_table "link_accounts", :force => true do |t|
    t.string   "source"
    t.string   "target"
    t.integer  "source_id"
    t.integer  "target_id"
    t.integer  "source_admin_id"
    t.integer  "target_admin_id"
    t.string   "accept"
    t.string   "request"
    t.boolean  "ignor"
    t.boolean  "remove"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "linkimages", :force => true do |t|
    t.string   "link_image"
    t.integer  "link_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "content_type"
    t.string   "file_size"
  end

  create_table "links", :force => true do |t|
    t.string   "product"
    t.string   "link"
    t.string   "user_name"
    t.string   "pwd_hint"
    t.text     "notes"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.integer  "user_id"
    t.boolean  "sharebox"
    t.string   "share_option"
  end

  create_table "meeting_attachments", :force => true do |t|
    t.string   "doc"
    t.integer  "meeting_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "meetings", :force => true do |t|
    t.string   "meeting_number"
    t.date     "meeting_date"
    t.time     "meeting_time"
    t.string   "meeting_location"
    t.string   "subject"
    t.text     "meeting_notes"
    t.text     "action_items"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.string   "attendee"
    t.string   "meeting_type"
    t.time     "to_meeting_time"
    t.string   "meeting_connection"
    t.string   "meeting_tool"
    t.string   "meeting_attnds"
  end

  add_index "meetings", ["contact_id"], :name => "index_meetings_on_contact_id"
  add_index "meetings", ["organization_id"], :name => "index_meetings_on_organization_id"

  create_table "my_threads", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "creation_date"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.string   "thread_number"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "users_count"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "account_type",  :default => "timesheet"
    t.boolean  "credit_status", :default => false
    t.date     "expiry_date"
  end

  add_index "organizations", ["account_type"], :name => "index_organizations_on_account_type"

  create_table "orgtabs", :force => true do |t|
    t.string   "tabname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orgtabs_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "orgtab_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "message"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "company_name"
  end

  create_table "pay_periods", :force => true do |t|
    t.date     "pay_start"
    t.date     "pay_end"
    t.boolean  "active"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "pay_day"
    t.integer  "organization_id"
    t.integer  "project_id"
    t.string   "timecode"
    t.string   "timesheet_number"
    t.string   "status"
  end

  add_index "pay_periods", ["organization_id"], :name => "index_pay_periods_on_organization_id"

  create_table "payments", :force => true do |t|
    t.string   "vendor"
    t.text     "exp_description"
    t.string   "paymethod"
    t.string   "date"
    t.integer  "expense_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.decimal  "amount",          :precision => 10, :scale => 1, :default => 0.0
    t.string   "project"
    t.string   "task"
    t.decimal  "approved_amt",    :precision => 10, :scale => 1, :default => 0.0
    t.integer  "project_id"
    t.integer  "project_type_id"
    t.decimal  "pay_amount",      :precision => 10, :scale => 1, :default => 0.0
  end

  create_table "project_changes", :force => true do |t|
    t.text     "status_details"
    t.integer  "per_completed"
    t.integer  "project_id"
    t.string   "project_type"
    t.string   "title"
    t.text     "notes"
    t.string   "prq_number"
    t.string   "action_required"
    t.string   "priority"
    t.date     "schedule_date"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "status_date"
    t.string   "entered_by"
    t.string   "reference"
    t.string   "owner"
    t.decimal  "amount",               :precision => 10, :scale => 1
    t.decimal  "variance",             :precision => 10, :scale => 1
    t.decimal  "percent_variance",     :precision => 10, :scale => 1
    t.decimal  "actual",               :precision => 10, :scale => 1
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.text     "analysis"
    t.string   "active"
    t.string   "suppliername"
    t.string   "updated_by"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.text     "prev_status_details"
    t.integer  "prev_per_completed"
    t.string   "prev_project_type"
    t.string   "prev_title"
    t.text     "prev_notes"
    t.string   "prev_action_required"
    t.string   "prev_priority"
    t.date     "prev_schedule_date"
    t.date     "prev_start_date"
    t.date     "prev_end_date"
    t.date     "prev_status_date"
    t.string   "prev_reference"
    t.string   "prev_owner"
    t.decimal  "prev_amount",          :precision => 10, :scale => 1
    t.integer  "prev_contact_id"
    t.text     "prev_analysis"
    t.string   "prev_active"
    t.string   "prev_suppliername"
    t.string   "tasktype"
    t.string   "prev_tasktype"
  end

  create_table "project_reports", :force => true do |t|
    t.string   "pdf_number"
    t.string   "report_user"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "project_reports_projects", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "project_report_id"
  end

  create_table "project_types", :force => true do |t|
    t.string   "type_name"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.integer  "organization_id"
    t.string   "project_group"
    t.date     "date_created"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "status"
    t.string   "budget_info"
    t.string   "proj_number"
    t.string   "created_by"
    t.boolean  "active"
    t.text     "proj_desc"
    t.integer  "projecttype_id"
    t.decimal  "hours_budget",    :precision => 10, :scale => 1, :default => 0.0
    t.decimal  "expense_budget",  :precision => 10, :scale => 1, :default => 0.0
    t.string   "status_check",                                   :default => "active"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "project_name"
    t.string   "description"
    t.decimal  "amount",           :precision => 10, :scale => 1, :default => 0.0
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.text     "notes"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.boolean  "active",                                          :default => false
    t.string   "action_required"
    t.date     "schedule_date"
    t.string   "entered_by"
    t.string   "prq_number"
    t.decimal  "variance",         :precision => 10, :scale => 1, :default => 0.0
    t.decimal  "percent_variance", :precision => 10, :scale => 1, :default => 0.0
    t.text     "status_details"
    t.integer  "per_completed"
    t.decimal  "actual",           :precision => 10, :scale => 1, :default => 0.0
    t.string   "priority"
    t.string   "owner"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "status_date"
    t.time     "deleted_at"
    t.string   "reference"
    t.text     "analysis"
    t.integer  "tasktype_id"
    t.integer  "project_type_id"
  end

  add_index "projects", ["contact_id"], :name => "index_projects_on_contact_id"
  add_index "projects", ["organization_id"], :name => "index_projects_on_organization_id"

  create_table "projects_statusreports", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "statusreport_id"
  end

  create_table "projecttypes", :force => true do |t|
    t.string   "projecttype"
    t.text     "usage"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "status_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.text     "usage"
  end

  create_table "statusreports", :force => true do |t|
    t.string   "report_number"
    t.date     "report_date"
    t.time     "report_time"
    t.string   "send_to"
    t.string   "sent_by"
    t.string   "subject"
    t.integer  "organization_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "report_user"
    t.string   "report_priority"
    t.string   "searched_projects"
    t.datetime "sent_date"
    t.string   "format"
    t.text     "custom_message"
  end

  add_index "statusreports", ["organization_id"], :name => "index_statusreports_on_organization_id"

  create_table "switch_tabs", :force => true do |t|
    t.string   "module_name"
    t.boolean  "state",       :default => true
    t.integer  "user_value"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tasktypes", :force => true do |t|
    t.string   "tasktype"
    t.date     "datecreated"
    t.integer  "organization_id"
    t.integer  "projects_count"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "usage"
  end

  create_table "thread_comments", :force => true do |t|
    t.text     "title"
    t.integer  "my_thread_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.integer  "user_id"
  end

  create_table "time_records", :force => true do |t|
    t.date     "activity_date"
    t.text     "description"
    t.decimal  "total_hours",   :precision => 10, :scale => 1
    t.integer  "pay_period_id"
    t.integer  "user_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "project_id"
  end

  add_index "time_records", ["pay_period_id"], :name => "index_time_records_on_pay_period_id"
  add_index "time_records", ["user_id"], :name => "index_time_records_on_user_id"

  create_table "timecodes", :force => true do |t|
    t.string   "code"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.text     "usage"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                             :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean  "admin"
    t.string   "name"
    t.string   "group"
    t.boolean  "active"
    t.integer  "organization_id"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.boolean  "superadmin",                      :default => false
    t.string   "chosed_plan",                     :default => "Plan1"
    t.boolean  "credit_status",                   :default => false
    t.integer  "email_status_reminder",           :default => 0
    t.date     "expiry_date"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["organization_id"], :name => "index_users_on_organization_id"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
