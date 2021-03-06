set(CMAKE_RELWITHDEBINFO_POSTFIX "")
set(CMAKE_MINSIZEREL_POSTFIX "")

set(PBD_BINARY_DEBUG_POSTFIX "_d" CACHE INTERNAL "Postfix for executables")
set(PBD_BINARY_RELWITHDEBINFO_POSTFIX "_rd" CACHE INTERNAL "Postfix for executables")
set(PBD_BINARY_MINSIZEREL_POSTFIX "_ms" CACHE INTERNAL "Postfix for executables")

if (NOT WIN32)
	if (NOT EXISTS ${CMAKE_BINARY_DIR}/CMakeCache.txt)
	  if (NOT CMAKE_BUILD_TYPE)
		set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
	  endif()
	endif()
endif()

option(USE_OpenMP "Use OpenMP" ON)
if(USE_OpenMP)
	FIND_PACKAGE(OpenMP)
	if(OPENMP_FOUND)
		SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
	endif()
endif()

if (WIN32)
    set(CMAKE_USE_RELATIVE_PATHS "1")
    # Set compiler flags
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MP /bigobj")
    set(CMAKE_CXX_FLAGS_RELEASE "/MD /MP /Ox /Ob2 /Oi /Ot /D NDEBUG")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "/MD /Zi /MP /Ox /Ob2 /Oi /Ot /D NDEBUG /bigobj")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "/INCREMENTAL:NO")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "/INCREMENTAL:NO")
    set(CMAKE_STATIC_LINKER_FLAGS_RELEASE "/INCREMENTAL:NO")
endif (WIN32)

if (UNIX)
    set(CMAKE_USE_RELATIVE_PATHS "1")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_DEBUG")
    # Set compiler flags for "release"
    set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG -march=native")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -DNDEBUG -march=native")
endif (UNIX)

if(APPLE)
    set(CMAKE_MACOSX_RPATH 1)
endif()

set (CMAKE_CXX_STANDARD 11)

add_definitions(-D_CRT_SECURE_NO_DEPRECATE)

OPTION(USE_DOUBLE_PRECISION "Use double precision"	ON)
if (USE_DOUBLE_PRECISION)
	add_definitions( -DUSE_DOUBLE)
endif (USE_DOUBLE_PRECISION)

