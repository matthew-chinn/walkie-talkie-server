class AddPartnerToProfile < ActiveRecord::Migration
  def change
      add_column :profiles, :partner_id, :integer
  end
end
