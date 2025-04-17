import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from dao.adoptable import IAdoptable

class AdoptionEvent:
    def __init__(self):
        self.participants = []

    def register_participant(self, participant: IAdoptable):
        self.participants.append(participant)

    def host_event(self):
        print("Adoption event is now live!")
        for participant in self.participants:
            try:
                participant.adopt()
            except Exception as e:
                print(f"Error during adoption: {e}")

"""class TestAnimal(IAdoptable):
    def adopt(self):
        print("Adopt method executed!")

if __name__ == "__main__":
    animal = TestAnimal()
    animal.adopt() """