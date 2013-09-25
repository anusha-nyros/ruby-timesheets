#encoding: utf-8
class ReportPdf < Prawn::Document
 
  def initialize(report, project,view)
    super(top_margin: 70)
    @rep_projects = report
    @project_report = project
    @view = view
    font "Helvetica"  
    stroke_color "f0ff0f"  
    report_number
    content_items
    page
    start_new_page
    content_report_items
    page_count.times do |i|
    go_to_page(i+1)
    bounding_box([bounds.right-50, bounds.bottom + 12], :width => 50) {
      text "Page #{i+1}"
    }
  end
    
  end
  
  def report_number
    text "Title : #{@project_report.pdf_number}", size: 18
    text "\n"
    text "Table of contents" ,size: 18 
    text "\n"
  end
  def content_items
    c = 0 
   @rep_projects.each do |item|
     c = c +1 
      text "#{ c}. #{item.title} - #{item.prq_number}"
      text "\n"
   end
   end

   def content_report_items
   
   text "Project Items" ,size: 18
   text "\n"
    @rep_projects.each do |item|
    text "Title:",:style => :bold
    if !item.title.blank?
    text "#{item.title}"
    
    end
    text "\n"
   text "Description:",:style => :bold
   if !item.notes.blank?
   text "#{item.notes}"
   
   end 
   text "\n"
   text "Analysis:" ,:style => :bold
   if !item.analysis.blank?
   text "#{item.analysis}"
   
   end
   text "\n"
   text "Images:"   ,:style => :bold
     if !item.attachments.blank?
      item.attachments.each do |a|
         if !a.content_type.blank?
               if a.content_type.include?("image") 
                  path = get_image_path(a.doc_url)
                  image path , :width => 200, :height => 200
               end 
         end
     end 
    end  
   move_down 10
   stroke_horizontal_rule
   move_down 30
   end

   end 

  def get_image_path(name)
         # return "#{Rails.root}/app/assets/images/#{name}"
         return "#{Rails.root}/public#{name}"
   
  end


end
