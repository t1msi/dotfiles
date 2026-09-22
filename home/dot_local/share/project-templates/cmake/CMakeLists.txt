cmake_minimum_required(VERSION 3.20)

project(@PROJECT_NAME@ LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(${PROJECT_NAME} src/main.cpp)

include(CTest)
if(BUILD_TESTING)
  add_test(NAME ${PROJECT_NAME}.runs COMMAND ${PROJECT_NAME})
endif()
