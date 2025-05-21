#include <iostream>
#include <vector>
#include <string>
#include <fstream>
using namespace std;

// Employee structure
struct Employee {
    string name;
    string phone;
    string address;
    bool isOccupied = false;
};

// Hash Table Class
class HashTable {
private:
    vector<Employee> table;
    int size;

    int hashFunction(const string &phone) {
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

    void createContact(const string &phone, const string &name, const string &address) {
        int index = hashFunction(phone);
        int attempt = 0;
        while (table[index].isOccupied) {
            index = quadraticProbing(index, ++attempt);
        }
        table[index] = {name, phone, address, true};
        cout << "Contact created successfully!\n";
    }

    void displayContacts() {
        for (const auto &record : table) {
            if (record.isOccupied) {
                cout << "Name: " << record.name 
                     << ", Phone: " << record.phone 
                     << ", Address: " << record.address << "\n";
            }
        }
    }

    void deleteContact(const string &phone) {
        int index = hashFunction(phone);
        int attempt = 0;
        while (table[index].isOccupied && table[index].phone != phone) {
            index = quadraticProbing(index, ++attempt);
            if (attempt > size) {
                cout << "Contact not found.\n";
                return;
            }
        }

        if (table[index].isOccupied && table[index].phone == phone) {
            table[index] = Employee(); // Reset the entry
            cout << "Contact deleted successfully!\n";
        } else {
            cout << "Contact not found.\n";
        }
    }

    void searchContact(const string &phone) {
        int index = hashFunction(phone);
        int attempt = 0;
        while (table[index].isOccupied && table[index].phone != phone) {
            index = quadraticProbing(index, ++attempt);
            if (attempt > size) {
                cout << "Contact not found.\n";
                return;
            }
        }

        if (table[index].isOccupied && table[index].phone == phone) {
            cout << "Name: " << table[index].name 
                 << ", Phone: " << table[index].phone 
                 << ", Address: " << table[index].address << "\n";
        } else {
            cout << "Contact not found.\n";
        }
    }

    void editContact(const string &phone) {
        int index = hashFunction(phone);
        int attempt = 0;
        while (table[index].isOccupied && table[index].phone != phone) {
            index = quadraticProbing(index, ++attempt);
            if (attempt > size) {
                cout << "Contact not found.\n";
                return;
            }
        }

        if (table[index].isOccupied && table[index].phone == phone) {
            string newName, newAddress;
            cout << "Enter new name: ";
            getline(cin, newName);
            cout << "Enter new address: ";
            getline(cin, newAddress);
            table[index].name = newName;
            table[index].address = newAddress;
            cout << "Contact updated successfully!\n";
        } else {
            cout << "Contact not found.\n";
        }
    }

    void clearContacts() {
        table.clear();
        table.resize(size);
        cout << "All contacts cleared successfully!\n";
    }
};

int main() {
    HashTable hashTable(10); // Initialize hash table with size 10
    int choice;
    do {
        cout << "1. Create Contact\n2. Display Contacts\n3. Delete Contact\n"
                "4. Search Contact\n5. Edit Contact\n6. Clear Contacts\n0. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;
        cin.ignore(); // Clear input buffer

        if (choice == 1) {
            string name, phone, address;
            cout << "Enter phone: ";
            getline(cin, phone);
            cout << "Enter name: ";
            getline(cin, name);
            cout << "Enter address: ";
            getline(cin, address);
            hashTable.createContact(phone, name, address);
        } else if (choice == 2) {
            hashTable.displayContacts();
        } else if (choice == 3) {
            string phone;
            cout << "Enter phone to delete: ";
            getline(cin, phone);
            hashTable.deleteContact(phone);
        } else if (choice == 4) {
            string phone;
            cout << "Enter phone to search: ";
            getline(cin, phone);
            hashTable.searchContact(phone);
        } else if (choice == 5) {
            string phone;
            cout << "Enter phone to edit: ";
            getline(cin, phone);
            hashTable.editContact(phone);
        } else if (choice == 6) {
            hashTable.clearContacts();
        }
    } while (choice != 0);

    cout << "Exiting program.\n";
    return 0;
}
