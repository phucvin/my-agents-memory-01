#include <iostream>
#include <string>
#include <vector>
#include <cstdlib>
#include <cstdio>
#include <memory>
#include <array>
#include <stdexcept>
#include <sstream>

#include "json.hpp"

using json = nlohmann::json;

// --- Helper for executing shell commands ---
std::string exec_command(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}

// --- Gemini API ---

std::string GEMINI_API_KEY;
const std::string MODEL = "gemini-1.5-flash"; // Or gemini-pro

json call_gemini(const json& contents, const json& tools) {
    std::string url = "https://generativelanguage.googleapis.com/v1beta/models/" + MODEL + ":generateContent?key=" + GEMINI_API_KEY;

    json request_body;
    request_body["contents"] = contents;
    request_body["tools"] = tools;

    std::string request_str = request_body.dump();

    // Construct curl command
    // Note: In a real app, use libcurl. This is a "minimal" agent using system curl.
    // Escape single quotes in request_str for shell usage is tricky.
    // Better to write to a temporary file.

    std::string temp_filename = "gemini_request.json";
    FILE* temp_file = fopen(temp_filename.c_str(), "w");
    if (!temp_file) throw std::runtime_error("Could not write temp file");
    fwrite(request_str.c_str(), 1, request_str.length(), temp_file);
    fclose(temp_file);

    std::string cmd = "curl -s -X POST -H \"Content-Type: application/json\" -d @" + temp_filename + " \"" + url + "\"";

    std::string response_str = exec_command(cmd.c_str());

    // Clean up
    remove(temp_filename.c_str());

    try {
        return json::parse(response_str);
    } catch (const std::exception& e) {
        std::cerr << "Failed to parse JSON response: " << e.what() << "\nResponse: " << response_str << std::endl;
        return json(nullptr);
    }
}

// --- Tools ---

bool is_valid_host(const std::string& host) {
    if (host.empty()) return false;
    for (char c : host) {
        if (!isalnum(c) && c != '.' && c != '-' && c != ':') {
            return false;
        }
    }
    return true;
}

std::string ping(const std::string& host) {
    if (!is_valid_host(host)) {
        return "Error: Invalid hostname. Only alphanumeric characters, dots, dashes, and colons are allowed.";
    }

    std::cout << "[Tool] Pinging " << host << "..." << std::endl;
    // Use -c 3 for 3 packets.
    std::string cmd = "ping -c 3 " + host;
    try {
        return exec_command(cmd.c_str());
    } catch (const std::exception& e) {
        return "Error executing ping: " + std::string(e.what());
    }
}

// --- Main Agent Loop ---

int main() {
    const char* api_key_env = std::getenv("GEMINI_API_KEY");
    if (!api_key_env) {
        std::cerr << "Error: GEMINI_API_KEY environment variable not set." << std::endl;
        return 1;
    }
    GEMINI_API_KEY = api_key_env;

    // Define tools
    json tools = json::array({
        {
            {"functionDeclarations", json::array({
                {
                    {"name", "ping"},
                    {"description", "Ping a host to check connectivity and latency."},
                    {"parameters", {
                        {"type", "OBJECT"},
                        {"properties", {
                            {"host", {
                                {"type", "STRING"},
                                {"description", "The hostname or IP address to ping."}
                            }}
                        }},
                        {"required", json::array({"host"})}
                    }}
                }
            })}
        }
    });

    json contents = json::array(); // History

    std::cout << "Gemini Agent (" << MODEL << "). Type 'exit' to quit.\n";

    while (true) {
        std::cout << "> ";
        std::string input;
        if (!std::getline(std::cin, input)) break;
        if (input == "exit") break;

        // Add user message
        contents.push_back({
            {"role", "user"},
            {"parts", {{{"text", input}}}}
        });

        bool turn_complete = false;
        while (!turn_complete) {
            json response = call_gemini(contents, tools);

            if (response.is_null() || !response.contains("candidates")) {
                std::cerr << "Invalid response from API." << std::endl;
                turn_complete = true;
                continue;
            }

            auto candidate = response["candidates"][0];
            auto parts = candidate["content"]["parts"];

            bool function_called = false;

            // Check for function calls
            for (const auto& part : parts) {
                if (part.contains("functionCall")) {
                    function_called = true;
                    auto fc = part["functionCall"];
                    std::string func_name = fc["name"];
                    json args = fc["args"];

                    std::cout << "[Agent] Calling tool: " << func_name << " with args " << args.dump() << std::endl;

                    // Add model's function call to history
                    // Important: The model's message must contain the functionCall
                    contents.push_back({
                        {"role", "model"},
                        {"parts", parts} // Keep all parts (thoughts + call)
                    });

                    // Execute tool
                    std::string tool_result;
                    if (func_name == "ping") {
                        std::string host = args.value("host", "");
                        tool_result = ping(host);
                    } else {
                        tool_result = "Error: Unknown function " + func_name;
                    }

                    // Send response back
                    // Role is "function" in OpenAI, but in Gemini REST it's "user" with "functionResponse" part?
                    // No, wait. The example showed:
                    // role: "user"
                    // parts: [{ "functionResponse": { ... } }]

                    // Actually, let's look at the "user" role vs "function" role carefully.
                    // "role": "function" is standard in OpenAI.
                    // Gemini REST API docs say:
                    /*
                    contents.push({
                      role: 'user',
                      parts: [{ functionResponse: function_response_part }]
                    });
                    */
                    // Yes, role is user.

                    json function_response_part = {
                        {"functionResponse", {
                            {"name", func_name},
                            {"response", {{"result", tool_result}}}
                        }}
                    };

                    contents.push_back({
                        {"role", "user"}, // Gemini uses 'user' role for function responses in the 'contents' list
                        {"parts", json::array({function_response_part})}
                    });

                    break; // Handle one function call at a time per loop iteration for simplicity (or handle multiple if needed, but let's stick to simple loop)
                }
            }

            if (!function_called) {
                // Just text response
                std::string text = "";
                for (const auto& part : parts) {
                    if (part.contains("text")) {
                        text += part["text"].get<std::string>();
                    }
                }
                std::cout << ">>> " << text << std::endl;

                // Add assistant response to history
                contents.push_back({
                    {"role", "model"},
                    {"parts", parts}
                });

                turn_complete = true;
            }
        }
    }

    return 0;
}
