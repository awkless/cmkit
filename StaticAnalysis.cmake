# SPDX-FileCopyrightText: 2026 Jason Pena <jasonpena@awkless.com>
# SPDX-License-Identifier: MIT

# Lint target files with clang-tidy.
#
# Will pick up the settings of a top-level `.clang-tidy` configuration file
# in the source directory.
#
# Arguments
# ---------
#
# ${ARGN}
#     List of C/C++ files to run clang-tidy on.
function(lint_with_clang_tidy)
    if(NOT ARGN)
        message(AUTHOR_WARNING "lint_with_clang_tidy called with no files. Skipping target creation")
        return()
    endif()

    set(CMAKE_EXPORT_COMPILE_COMMANDS ON PARENT_SCOPE)
    find_program(CLANG_TIDY_EXE NAMES clang-tidy REQUIRED)
    set(COMPILE_COMMANDS_PATH "${CMAKE_BINARY_DIR}/compile_commands.json")
    add_custom_target(
        run_clang_tidy
        COMMAND ${CLANG_TIDY_EXE} "-p" "${CMAKE_BINARY_DIR}" "${ARGN}"
	DEPENDS "${COMPILE_COMMANDS_PATH}"
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        COMMENT "Run clang-tidy analysis"
        VERBATIM
    )
endfunction()
