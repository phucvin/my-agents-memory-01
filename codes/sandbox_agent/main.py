import os
import google.generativeai as genai
from google.api_core import retry

# Configure API
if "GEMINI_API_KEY" not in os.environ:
    raise ValueError("GEMINI_API_KEY environment variable not set.")
genai.configure(api_key=os.environ["GEMINI_API_KEY"])

# Define sandbox directory
SANDBOX_DIR = os.path.abspath("codes/sandbox_agent/sandbox")
if not os.path.exists(SANDBOX_DIR):
    os.makedirs(SANDBOX_DIR)

print(f"Sandbox Directory: {SANDBOX_DIR}")

def list_files(path: str = ".") -> list[str]:
    """Lists files in the specified path relative to the sandbox directory."""
    print(f"[TOOL] list_files path={path}")
    target_dir = os.path.abspath(os.path.join(SANDBOX_DIR, path))
    # Security check
    if not target_dir.startswith(SANDBOX_DIR):
        return [f"Error: Access denied to path {path} (outside sandbox)"]

    if not os.path.exists(target_dir):
        return [f"Error: Directory {path} does not exist"]

    try:
        return os.listdir(target_dir)
    except Exception as e:
        return [f"Error: {str(e)}"]

def read_file(filepath: str) -> str:
    """Reads a file from the sandbox directory."""
    print(f"[TOOL] read_file filepath={filepath}")
    target_path = os.path.abspath(os.path.join(SANDBOX_DIR, filepath))
    if not target_path.startswith(SANDBOX_DIR):
        return "Error: Access denied (outside sandbox)"

    try:
        with open(target_path, "r") as f:
            return f.read()
    except Exception as e:
        return f"Error: {str(e)}"

def write_file(filepath: str, content: str) -> str:
    """Writes content to a file in the sandbox directory."""
    print(f"[TOOL] write_file filepath={filepath}")
    target_path = os.path.abspath(os.path.join(SANDBOX_DIR, filepath))
    if not target_path.startswith(SANDBOX_DIR):
        return "Error: Access denied (outside sandbox)"

    try:
        # Ensure parent dirs exist
        os.makedirs(os.path.dirname(target_path), exist_ok=True)
        with open(target_path, "w") as f:
            f.write(content)
        return "File written successfully."
    except Exception as e:
        return f"Error: {str(e)}"

tools = [list_files, read_file, write_file]

# Initialize model
model = genai.GenerativeModel(
    model_name='gemini-flash-latest',
    tools=tools
)

# Start chat with automatic function calling
chat = model.start_chat(enable_automatic_function_calling=True)

user_prompt = "create hello.txt containing some text and files.txt containing the files in the parent directory"
print(f"\nUser Prompt: {user_prompt}\n")

try:
    response = chat.send_message(user_prompt)
    print("\nModel Response:")
    print(response.text)
except Exception as e:
    print(f"\nAn error occurred: {e}")

# Print tool usage history for verification
print("\n--- Interaction History ---")
for part in chat.history:
    if part.role == "user":
        print(f"User: {part.parts[0].text}")
    elif part.role == "model":
        for p in part.parts:
            if fn := p.function_call:
                print(f"Model (Tool Call): {fn.name}({fn.args})")
            elif p.text:
                print(f"Model (Text): {p.text}")
