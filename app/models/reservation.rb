class Reservation < ApiController
  belongs_to :service

  validates :pickup_address, :drop_address, :description, :contact, :pickup_date, presence: true
  validates :pickup_date_cannot_be_in_the_past

  private

  def pickup_date_cannot_be_in_the_past
    if pickup_date.present? && pickup_date < Date.today
      errors.add(:pickup_date, "Date can't be in the past")
    end
  end
end
