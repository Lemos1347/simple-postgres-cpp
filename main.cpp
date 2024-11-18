#include <cstddef>
#include <iostream>
#include <pqxx/pqxx>

int main() {
  try {
    // Connect to the database
    pqxx::connection connection("dbname=testdb user=user password=password "
                                "hostaddr=127.0.0.1 port=5432");

    if (connection.is_open()) {
      std::cout << "Opened database successfully: " << connection.dbname()
                << std::endl;
    } else {
      std::cout << "Can't open database" << std::endl;
      return 1;
    }

    // Create a transaction
    pqxx::work W(connection);

    // Execute SQL query
    pqxx::result R = W.exec("SELECT version()");

    // Print the result
    std::cout << "PostgreSQL version: " << R[0][0].c_str() << std::endl;

    // Commit transaction
    W.commit();

  } catch (const std::exception &e) {
    std::cerr << e.what() << std::endl;
    return 1;
  }

  return 0;
}
