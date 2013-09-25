#encoding: utf-8
class InvoiceReportPdf < Prawn::Document

  def initialize(invoice, line_item,view)
    super(top_margin: 70)
    @invoice = invoice
    @line_item = line_item
    @view = view
    font "Helvetica"  
    stroke_color "f0ff0f"  
    headding
    start_new_page
    put_table
    page_count.times do |i|
  	  go_to_page(i+1)
  	  bounding_box([bounds.right-50, bounds.bottom + 12], :width => 50) {
          text "Page #{i+1}"
          }
    end  
  end
def headding
    move_down 255
    text "Invoice Report", size: 30, style: :bold,align: :center
end #end of headding

def put_table
    move_down 20
    text "Invoice", size: 30, style: :bold,align: :center
    move_down 20
    data=Array.new
    data << ["Invoice","Date","Client","Reference", "Quantity", "Units", "Amount","Description","Comments"] 
    data << [@invoice.invoice,@invoice.date,@invoice.client,@invoice.reference,@line_item.quantity,@line_item.unit,@line_item.amount,@line_item.description,@line_item.text_comment]
   table data do
      row(0).font_style = :bold
      row(0).align = :center
#      columns(1..9).width=60
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
 end #end of put_table
end
