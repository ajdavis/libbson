if (ENABLE_MAINTAINER_FLAGS)
   include(CheckCCompilerFlag)

   message(STATUS "Detecting available maintainer flags")
   set (MESSAGES_ENABLED 0)
   file (READ "build/maintainer-flags.txt" MAINTAINER_FLAGS)
   # Convert file contents into a CMake list (where each element in the list
   # is one line of the file)
   #
   string (REGEX REPLACE ";" "\\\\;" MAINTAINER_FLAGS "${MAINTAINER_FLAGS}")
   string (REGEX REPLACE "\n" ";" MAINTAINER_FLAGS "${MAINTAINER_FLAGS}")

   foreach (MAINTAINER_FLAG ${MAINTAINER_FLAGS})
      message (STATUS "found flag ${MAINTAINER_FLAG}")
      check_c_compiler_flag ("${MAINTAINER_FLAG}" FLAG_OK)
      if (FLAG_OK)
         message (STATUS "${MAINTAINER_FLAG} works")
         set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${MAINTAINER_FLAG}")
      else ()
         message (STATUS "${MAINTAINER_FLAG} does not work")
      endif ()
      unset (FLAG_OK CACHE)
   endforeach ()

   set (MESSAGES_ENABLED 1)
   message(STATUS "Maintainer flags: ${CMAKE_C_FLAGS}")
endif ()
