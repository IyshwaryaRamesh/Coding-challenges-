from entity.donation import Donation

class ItemDonation(Donation):
    def __init__(self, donor_name: str, amount: float, item_type: str, donation_date):
        super().__init__(donor_name, amount)
        self.item_type = item_type
        self.donation_date = donation_date

    def record_donation(self):
        print(f"Item donation of type {self.item_type} worth ${self.amount} by {self.donor_name} recorded on {self.donation_date}.")
