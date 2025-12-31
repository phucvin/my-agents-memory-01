package main

import (
	"fmt"
	"log"
	"strings"

	// The module declares its path as github.com/microsandbox/microsandbox/sdk/go
	// even though the repository is hosted at github.com/zerocore-ai/microsandbox
	msb "github.com/microsandbox/microsandbox/sdk/go"
)

func main() {
	// Initialize the sandbox
	// We'll use a Node.js sandbox as requested
	// Note: The microsandbox server must be running for this to work.
	// We use "dummy-key" because we are running in --dev mode (or assuming it),
	// but the SDK insists on an API key being present.
	sandbox := msb.NewNodeSandbox(
		msb.WithName("test-node-sandbox"),
		msb.WithApiKey("dummy-key"),
	)

	// Start the sandbox
	// Image "" uses default. Memory 512MB, 1 CPU.
	fmt.Println("Starting sandbox...")
	err := sandbox.Start("", 512, 1)
	if err != nil {
		if strings.Contains(err.Error(), "connection refused") {
			log.Fatalf("Failed to connect to microsandbox server. Please ensure it is running with `msb server start --dev`. Error: %v", err)
		}
		log.Fatalf("Failed to start sandbox: %v", err)
	}
	defer func() {
		fmt.Println("Stopping sandbox...")
		if err := sandbox.Stop(); err != nil {
			log.Printf("Failed to stop sandbox: %v", err)
		}
	}()

	// 1. Run command to write simple JS code to file
	// We use 'sh -c' to handle redirection
	jsCode := "console.log('Hello from Microsandbox Go SDK!');"
	writeCmd := fmt.Sprintf("echo %q > hello.js", jsCode)

	fmt.Printf("Running command: sh -c %s\n", writeCmd)
	cmdExec, err := sandbox.Command().Run("sh", []string{"-c", writeCmd})
	if err != nil {
		log.Fatalf("Failed to run write command: %v", err)
	}

	// Check for execution success
	if !cmdExec.IsSuccess() {
		output, _ := cmdExec.GetOutput()
		stderr, _ := cmdExec.GetError()
		log.Fatalf("Write command failed.\nOutput: %s\nError: %s", output, stderr)
	}
	fmt.Println("File 'hello.js' created successfully inside sandbox.")

	// 2. Run with node
	fmt.Println("Running command: node hello.js")
	nodeExec, err := sandbox.Command().Run("node", []string{"hello.js"})
	if err != nil {
		log.Fatalf("Failed to run node command: %v", err)
	}

	output, _ := nodeExec.GetOutput()
	stderr, _ := nodeExec.GetError()

	if !nodeExec.IsSuccess() {
		log.Fatalf("Node command failed.\nOutput: %s\nError: %s", output, stderr)
	}

	fmt.Printf("Node execution output:\n%s\n", output)
}
