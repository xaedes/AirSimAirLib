cmake_minimum_required(VERSION 3.8.0)
project(AirSimAirLib_meta)

option(ENABLE_AIRSIMAIRLIB_EXAMPLE "ENABLE_AIRSIMAIRLIB_EXAMPLE" ON)

add_subdirectory(rpclib)
add_subdirectory(AirSimAirLib)

# if(ENABLE_AIRSIMAIRLIB_EXAMPLE)
add_subdirectory(AirSimAirLib_example)
# endif()
