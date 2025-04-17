from datetime import datetime
from entity.donation import Donation

class CashDonation(Donation):
    def __init__(self, donor_name: str, amount: float, donation_date: datetime):
        super().__init__(donor_name, amount)
        self.donation_date = donation_date

    def record_donation(self):
        print(f"Cash donation of ${self.amount} by {self.donor_name} on {self.donation_date.strftime('%Y-%m-%d')} recorded.")