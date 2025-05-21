#!/bin/bash

echo "Running fake tests..."
[ -f fail_tests.flag ] && echo "Tests failed." && exit 1
echo "Tests passed!"
exit 0
