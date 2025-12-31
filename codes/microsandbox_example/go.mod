module microsandbox_example

go 1.24.3

require github.com/microsandbox/microsandbox/sdk/go v0.0.0-20251230183715-79f8d3257317

require github.com/google/uuid v1.5.0 // indirect

// The module github.com/microsandbox/microsandbox/sdk/go is actually hosted in the zerocore-ai repo.
// We point it to the correct location.
replace github.com/microsandbox/microsandbox/sdk/go => github.com/zerocore-ai/microsandbox/sdk/go v0.0.0-20251230183715-79f8d3257317
