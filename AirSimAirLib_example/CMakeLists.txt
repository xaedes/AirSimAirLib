cmake_minimum_required(VERSION 3.8.0)
project(AirSimAirLib_example)

add_executable(AirSimAirLib_example example.cpp)
target_link_libraries(AirSimAirLib_example PUBLIC AirSimAirLib)

