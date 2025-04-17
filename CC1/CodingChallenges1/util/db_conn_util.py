import pyodbc

class DBConnUtil:
    @staticmethod
    def get_connection():
        return pyodbc.connect(
            "Driver={ODBC Driver 17 for SQL Server};"
            "Server=LAPTOP-QB4MOV49;"
            "Database=PetPals;"
            "Trusted_Connection=yes;"
        )

