add_library(wm8960 SHARED src/wm8960.cpp)
set_target_properties(wm8960 PROPERTIES OUTPUT_NAME "wm8960")
target_include_directories(wm8960 PUBLIC include)
set(DCMAKE_BUILD_TYPE=$DEBUG)
