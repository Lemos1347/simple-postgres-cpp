cmake_minimum_required(VERSION 3.10)
project(cpp-libpqxx-app CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find libpqxx
find_package(PkgConfig REQUIRED)
pkg_check_modules(PQXX REQUIRED libpqxx)

# Add executable
add_executable(cpp-libpqxx-app main.cpp)

# Link libraries
target_link_libraries(cpp-libpqxx-app ${PQXX_LIBRARIES})

# Include directories
target_include_directories(cpp-libpqxx-app PUBLIC ${PQXX_INCLUDE_DIRS})
