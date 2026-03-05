add_library(bar SHARED src/bar.cpp)
set_target_properties(bar PROPERTIES OUTPUT_NAME "bar")
target_include_directories(bar PUBLIC include)
