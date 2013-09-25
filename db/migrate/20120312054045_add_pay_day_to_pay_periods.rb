class AddPayDayToPayPeriods < ActiveRecord::Migration
  def change
    add_column :pay_periods, :pay_day, :date

  end
end
