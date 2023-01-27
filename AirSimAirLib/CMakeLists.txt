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


if (WIN32)
    target_compile_definitions(${PROJECT_NAME} PRIVATE
        -D_UNICODE -DUNICODE
    )
endif()

find_package(Eigen3 CONFIG REQUIRED)

set_target_properties(${PROJECT_NAME} 
  PROPERTIES
    CXX_EXTENSIONS OFF
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    # COMPILE_FLAGS "${CMAKE_CXX_FLAGS} ${RPCLIB_EXTRA_FLAGS}"
)
target_include_directories(
    ${PROJECT_NAME}
    PUBLIC
        $<INSTALL_INTERFACE:include>    
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        ${RPCLIB_INCLUDE_DIR}
)

# target_link_libraries(${PROJECT_NAME} PUBLIC rpclib::rpc)
target_link_libraries(${PROJECT_NAME} PUBLIC ${RPCLIB_LIBS})
target_link_libraries(${PROJECT_NAME} PUBLIC Eigen3::Eigen)

# actually AirSimAirLib dependency should add -pthreads. 
# for unknown reasons setting RPCLIB_EXTRA_FLAGS via target_compile_options will only work to compile AirSimAirLib itself.
# when linking against it the -pthreads from RPCLIB_EXTRA_FLAGS is lost.
# so instead of relying on -pthreads flag we link against pthread here in the modern cmake way:
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PUBLIC Threads::Threads)
