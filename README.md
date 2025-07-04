# Test Bench Session

TestBench's core state machine.

`TestBench::Session` implements the core testing mechanisms of TestBench: tests, contexts, comments, assertions, and test file
execution. Sessions also maintain the pass/fail status of the test run. A diagnostic substitute session is also included that
records session telemetry so that test abstractions built using TestBench
(called "[Fixtures](http://test-bench.software/user-guide/fixtures.html)") can observed and tested in isolation.

## Documentation

See the [TestBench website](http://test-bench.software) for more information, examples, and user guides.

## License

The `test_bench-session` library is released under the [MIT License](./MIT-License.txt)
