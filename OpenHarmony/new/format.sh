find . | grep -E '\.h$|\.cpp$' | xargs clang-format-14 -style=file -i
