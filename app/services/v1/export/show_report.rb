class V1::Export::ShowReport

  def initialize(opts={})
    @show = Show.find(opts[:id])
  end

  def process
    package = Axlsx::Package.new
    package.workbook.add_worksheet(:name => "Show Report") do |sheet|
      sheet.add_row ['Seat Id', 'Seat Category', 'Seat Number', 'Booked']
      @show.seats.find_each do |seat|
        sheet.add_row [
          seat.id,
          seat.category,
          seat.number,
          seat.is_booked,
        ]
      end
    end
    file_path = "uploads/exports/Show_Report_#{DateTime.now.strftime("%Y%m%d-%H%M%S")}.xlsx"
    package.serialize("#{Rails.root}/public/#{file_path}")
    return file_path
  end
end
