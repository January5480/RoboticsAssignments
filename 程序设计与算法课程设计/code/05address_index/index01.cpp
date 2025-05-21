#include <iostream>
#include <vector>
#include <fstream>
#include <string>
using namespace std;

// Employee record structure
struct Employee {
    string name;
    string address;
    string phone;
    bool isOccupied = false;
};

// Hash Table class
class HashTable {
private:
    vector<Employee> table;
    int size;

    int hashFunction(string phone) {
        int hash = 0;
        for (char c : phone) hash = (hash * 31 + c) % size;
        return hash;
    }

    int quadraticProbing(int index, int attempt) {
        return (index + attempt * attempt) % size;
    }

public:
    HashTable(int s) : size(s) {
        table.resize(size);
    }

    void addEmployee(const string &phone, const string &name, const string &address) {
        int index = hashFunction(phone);
        int attempt = 0;
        while (table[index].isOccupied) {
            index = quadraticProbing(hashFunction(phone), ++attempt);
        }
        table[index] = {name, address, phone, true};
        cout << "Employee added successfully!\n";
    }

    void searchEmployee(const string &phone) {
        int index = hashFunction(phone);
        int attempt = 0;
        while (table[index].isOccupied && table[index].phone != phone) {
            index = quadraticProbing(hashFunction(phone), ++attempt);
            if (attempt > size) {
                cout << "Employee not found.\n";
                return;
            }
        }

        if (table[index].isOccupied && table[index].phone == phone) {
            cout << "Record Found:\n";
            cout << "Name: " << table[index].name << "\n";
            cout << "Address: " << table[index].address << "\n";
            cout << "Phone: " << table[index].phone << "\n";
        } else {
            cout << "Employee not found.\n";
        }
    }

    void displayAll() {
        for (const auto &record : table) {
            if (record.isOccupied) {
                cout << "Name: " << record.name << ", Phone: " << record.phone 
                     << ", Address: " << record.address << "\n";
            }
        }
    }

    void saveToFile(const string &filename) {
        ofstream file(filename);
        if (file.is_open()) {
            for (const auto &record : table) {
                if (record.isOccupied) {
                    file << record.phone << "," << record.name << "," << record.address << "\n";
                }
            }
            file.close();
            cout << "Data saved to " << filename << " successfully!\n";
        } else {
            cout << "Error opening file for saving.\n";
        }
    }
};

int main() {
    HashTable hashTable(10); // Initialize with size 10
    int choice;
    do {
        cout << "1. Add Employee\n2. Search Employee\n3. Display All\n4. Save to File\n0. Exit\nEnter choice: ";
        cin >> choice;
        cin.ignore();

        if (choice == 1) {
            string phone, name, address;
            cout << "Enter phone number: ";
            getline(cin, phone);
            cout << "Enter name: ";
            getline(cin, name);
            cout << "Enter address: ";
            getline(cin, address);
            hashTable.addEmployee(phone, name, address);
        } else if (choice == 2) {
            string phone;
            cout << "Enter phone number to search: ";
            getline(cin, phone);
            hashTable.searchEmployee(phone);
        } else if (choice == 3) {
            hashTable.displayAll();
        } else if (choice == 4) {
            hashTable.saveToFile("contacts.txt");
        }
    } while (choice != 0);

    cout << "Exiting program.\n";
    return 0;
}
