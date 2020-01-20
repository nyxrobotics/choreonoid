function(CHOREONOID_BODY_ADD_SIMPLE_CONTROLLER target)

  add_library(${target} SHARED ${ARGN})

  target_link_libraries(${target} CnoidBody)

  if(MSVC)
    target_link_options(${target} PRIVATE "/NODEFAULTLIB:LIBCMT")
  endif()

  set_target_properties(${target} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CHOREONOID_PLUGIN_SUBDIR}/simplecontroller
    LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CHOREONOID_PLUGIN_SUBDIR}/simplecontroller
    PREFIX "")

  if(CHOREONOID_ENABLE_INSTALL_RPATH)
    set_target_properties(${target} PROPERTIES INSTALL_RPATH "$ORIGIN")
  endif()

  CHOREONOID_SET_HEADER_FILES(${ARGN})

  install(TARGETS ${target}
    RUNTIME DESTINATION ${CHOREONOID_PLUGIN_SUBDIR}/simplecontroller
    LIBRARY DESTINATION ${CHOREONOID_PLUGIN_SUBDIR}/simplecontroller)

endfunction()

# Deprecated
function(add_cnoid_simple_controller)
  CHOREONOID_BODY_ADD_SIMPLE_CONTROLLER(${ARGV})
endfunction()

# Body handler
function(add_cnoid_body_handler)
  set(target ${ARGV0})
  list(REMOVE_AT ARGV 0)
  add_library(${target} SHARED ${ARGV})
  set_target_properties(${target} PROPERTIES
    PREFIX "" LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CNOID_PLUGIN_SUBDIR}/bodyhandler)
  if(CHOREONOID_ENABLE_INSTALL_RPATH)
    set_target_properties(${target} PROPERTIES INSTALL_RPATH "$ORIGIN")
  endif()
  target_link_libraries(${target} CnoidBody)
  install(TARGETS ${target}
    RUNTIME DESTINATION ${CNOID_PLUGIN_SUBDIR}/bodyhandler
    LIBRARY DESTINATION ${CNOID_PLUGIN_SUBDIR}/bodyhandler)
endfunction()

# Body customizer (deprecated)
function(add_cnoid_body_customizer)
  set(target ${ARGV0})
  list(REMOVE_AT ARGV 0)
  add_library(${target} SHARED ${ARGV})
  set_target_properties(${target} PROPERTIES
    PREFIX ""
    COMPILE_DEFINITIONS "CNOID_BODY_CUSTOMIZER"
    LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CNOID_PLUGIN_SUBDIR}/customizer)
  if(CHOREONOID_ENABLE_INSTALL_RPATH)
    set_target_properties(${target} PROPERTIES INSTALL_RPATH "$ORIGIN")
  endif()
  target_link_libraries(${target} CnoidBase)
  install(TARGETS ${target}
    RUNTIME DESTINATION ${CNOID_PLUGIN_SUBDIR}/customizer
    LIBRARY DESTINATION ${CNOID_PLUGIN_SUBDIR}/customizer)
endfunction()