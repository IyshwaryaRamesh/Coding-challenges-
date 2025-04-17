from abc import ABC, abstractmethod

class Donation(ABC):
    def __init__(self, donor_name: str, amount: float):
        self.donor_name = donor_name
        self.amount = amount

    @abstractmethod
    def record_donation(self):
        pass