cmake_minimum_required(VERSION 3.14)

project(Finger-s-World VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Core Quick QuickControls2 REQUIRED)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

set(PROJECT_SOURCES
        main.cpp
        Cpp/File/file.h
        Cpp/File/file.cpp
        qml.qrc
        image.qrc
        js.qrc
        file.qrc
        music.qrc
        icon.rc
)

SET(WIN)
IF (WIN32)
    list(APPEND WIN WIN32)
ENDIF ()
qt6_add_big_resources(PROJECT_SOURCES music.qrc)
qt_import_qml_plugins(Finger-s-World)
add_executable(Finger-s-World
    ${WIN}
    ${PROJECT_SOURCES}
)
target_compile_definitions(Finger-s-World
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(Finger-s-World
  PRIVATE Qt6::Core Qt6::Quick Qt6::QuickControls2)
