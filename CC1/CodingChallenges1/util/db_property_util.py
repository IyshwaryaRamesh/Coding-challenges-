class DBPropertyUtil:
    @staticmethod
    def get_connection_string(file_name: str):
        return {
            "server": "LAPTOP-QB4MOV49",
            #"server": "localhost\\SQLEXPRESS",
            #"user": "sa",
            "database": "PetPals"
        }