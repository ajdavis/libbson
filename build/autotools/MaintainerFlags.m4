AS_IF(
   [test "x$enable_maintainer_flags" = "xyes" && test "x$GCC" = "xyes"],
   [
    # clang only warns if it doesn't support a warning option, turn it into an
    # error so we really know if whether it supports it.
    AX_CHECK_COMPILE_FLAG(
       "-Werror=unknown-warning-option",
       [UNKNOWN_OPTION="-Werror=unknown-warning-option"],
       [UNKNOWN_OPTION=""])

    # Read maintainer-flags.txt and split on newline.
    m4_foreach([MAINTAINER_FLAG], m4_split(m4_esyscmd_s(cat build/maintainer-flags.txt), [[
]]), [
        AS_ECHO(["one flag MAINTAINER_FLAG"])
        AX_CHECK_COMPILE_FLAG(
           MAINTAINER_FLAG,
           [MAINTAINER_CFLAGS="$MAINTAINER_CFLAGS MAINTAINER_FLAG"],
           [],
           [UNKNOWN_OPTION])
    ])
   ]

   AC_SUBST(MAINTAINER_CFLAGS)
)
