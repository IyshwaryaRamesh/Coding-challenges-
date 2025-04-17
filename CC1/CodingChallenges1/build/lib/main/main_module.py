from datetime import datetime
from entity.cash_donation import CashDonation
from entity.item_donation import ItemDonation
from dao.shelter_service import ShelterService

def main():
    service = ShelterService()

    while True:
        print("\n===== Welcome to PetPals Adoption Platform =====")
        print("1. View Available Pets")
        print("2. Donate Cash")
        print("3. Donate Item")
        print("4. Register for Adoption Event")
        print("5. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            service.get_all_pets()

        elif choice == '2':
            donor_name = input("Enter your name: ")
            try:
                amount = float(input("Enter donation amount: "))
                donation_date = datetime.now()
                donation = CashDonation(donor_name, amount, donation_date)
                service.record_cash_donation(donation)
            except ValueError:
                print("Invalid input for amount.")

        elif choice == '3':
            donor_name = input("Enter your name: ")
            try:
                amount = float(input("Enter estimated item value: "))
                item_type = input("Enter item type (e.g., food, toys): ")
                donation = ItemDonation(donor_name, amount, item_type)
                service.record_item_donation(donation)
            except ValueError:
                print("Invalid input for amount.")

        elif choice == '4':
            name = input("Enter participant name: ")
            service.register_for_event(name)

        elif choice == '5':
            print("Thank you for visiting PetPals. Goodbye!")
            break

        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()