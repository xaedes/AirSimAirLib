cmake_minimum_required(VERSION 3.8.0)

project(AirSimAirLib)

file(GLOB_RECURSE ${PROJECT_NAME}_sources 
    src/api/*.cpp
    src/common/common_utils/*.cpp
    src/safety/*.cpp
    src/vehicles/car/api/*.cpp
    src/vehicles/multirotor/*.cpp
    src/vehicles/multirotor/api/*.cpp
)

add_library(${PROJECT_NAME} STATIC ${${PROJECT_NAME}_sources})
target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
        $<INSTALL_INTERFACE:include>    
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

if (WIN32)
    target_compile_definitions(${PROJECT_NAME} PRIVATE
        -D_UNICODE -DUNICODE
    )
endif()

set_target_properties(${PROJECT_NAME} 
  PROPERTIES
    CXX_EXTENSIONS OFF
    WINDOWS_EXPORT_ALL_SYMBOLS ON
)

find_package(Eigen3 CONFIG REQUIRED)

target_link_libraries(${PROJECT_NAME} PUBLIC rpc)
# target_link_libraries(${PROJECT_NAME} PUBLIC rpclib::rpc)
target_link_libraries(${PROJECT_NAME} PUBLIC Eigen3::Eigen)
