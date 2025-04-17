class PetShelter:
    def __init__(self):
        self.available_pets = []

    def add_pet(self, pet):
        self.available_pets.append(pet)

    def remove_pet(self, pet):
        if pet in self.available_pets:
            self.available_pets.remove(pet)

    def list_available_pets(self):
        for pet in self.available_pets:
            try:
                print(pet)
            except AttributeError:
                print("Some pet information is missing.")