from util.db_conn_util import DBConnUtil
from entity.cash_donation import CashDonation
from entity.item_donation import ItemDonation

class ShelterService:
    def __init__(self):
        self.conn = DBConnUtil.get_connection("db.properties")

    def get_all_pets(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT name, age, breed FROM pets")
            pets = cursor.fetchall()
            for pet in pets:
                print(f"Name: {pet[0]}, Age: {pet[1]}, Breed: {pet[2]}")
        except Exception as e:
            print(f"Error fetching pets: {e}")

    def record_cash_donation(self, donation: CashDonation):
        try:
            cursor = self.conn.cursor()
            sql = "INSERT INTO donations (donor_name, amount, donation_type, donation_date) VALUES (?, ?, ?, ?)"
            cursor.execute(sql, (donation.donor_name, donation.amount, 'Cash', donation.donation_date))
            self.conn.commit()
            print("Cash donation recorded successfully.")
        except Exception as e:
            print(f"Error recording donation: {e}")

    def record_item_donation(self, donation: ItemDonation):
        try:
            cursor = self.conn.cursor()
            sql = "INSERT INTO donations (donor_name, amount, donation_type, item_type) VALUES (?, ?, ?, ?)"
            cursor.execute(sql, (donation.donor_name, donation.amount, 'Item', donation.item_type))
            self.conn.commit()
            print("Item donation recorded successfully.")
        except Exception as e:
            print(f"Error recording item donation: {e}")

    def register_for_event(self, participant_name):
        try:
            cursor = self.conn.cursor()
            sql = "INSERT INTO participants (name) VALUES (?)"
            cursor.execute(sql, (participant_name,))
            self.conn.commit()
            print("Participant registered for adoption event.")
        except Exception as e:
            print(f"Error registering for event: {e}")