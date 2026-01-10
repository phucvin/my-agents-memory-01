import { FunctionTool } from '@google/adk';
import { z } from 'zod';
import * as fs from 'fs';
import * as path from 'path';

const SANDBOX_DIR = path.resolve(__dirname, '../sandbox');

// Ensure sandbox directory exists
if (!fs.existsSync(SANDBOX_DIR)) {
  fs.mkdirSync(SANDBOX_DIR, { recursive: true });
}

function resolvePath(relativePath: string): string {
  const resolved = path.resolve(SANDBOX_DIR, relativePath);
  if (!resolved.startsWith(SANDBOX_DIR)) {
    throw new Error('Access denied: Path is outside the sandbox directory.');
  }
  return resolved;
}

export const listFilesTool = new FunctionTool({
  name: 'list_files',
  description: 'Lists files in a directory within the sandbox.',
  parameters: z.object({
    directory: z.string().describe('The directory to list files from (relative to sandbox root). Defaults to root.'),
  }),
  execute: ({ directory }) => {
    try {
      const dirPath = resolvePath(directory || '.');
      const files = fs.readdirSync(dirPath);
      return { status: 'success', files };
    } catch (error: any) {
      return { status: 'error', message: error.message };
    }
  },
});

export const readFileTool = new FunctionTool({
  name: 'read_file',
  description: 'Reads the content of a file.',
  parameters: z.object({
    filepath: z.string().describe('The path of the file to read (relative to sandbox root).'),
  }),
  execute: ({ filepath }) => {
    try {
      const fullPath = resolvePath(filepath);
      const content = fs.readFileSync(fullPath, 'utf-8');
      return { status: 'success', content };
    } catch (error: any) {
      return { status: 'error', message: error.message };
    }
  },
});

export const writeFileTool = new FunctionTool({
  name: 'write_file',
  description: 'Writes content to a file. Overwrites if it exists.',
  parameters: z.object({
    filepath: z.string().describe('The path of the file to write (relative to sandbox root).'),
    content: z.string().describe('The content to write to the file.'),
  }),
  execute: ({ filepath, content }) => {
    try {
      const fullPath = resolvePath(filepath);
      fs.writeFileSync(fullPath, content, 'utf-8');
      return { status: 'success', message: `File ${filepath} written successfully.` };
    } catch (error: any) {
      return { status: 'error', message: error.message };
    }
  },
});

export const findAndReplaceTool = new FunctionTool({
  name: 'find_and_replace',
  description: 'Replaces all occurrences of a string in a file with a new string.',
  parameters: z.object({
    filepath: z.string().describe('The path of the file to modify (relative to sandbox root).'),
    search_string: z.string().describe('The string to search for.'),
    replace_string: z.string().describe('The string to replace with.'),
  }),
  execute: ({ filepath, search_string, replace_string }) => {
    try {
      const fullPath = resolvePath(filepath);
      if (!fs.existsSync(fullPath)) {
        throw new Error(`File ${filepath} does not exist.`);
      }
      let content = fs.readFileSync(fullPath, 'utf-8');
      // Use global replace
      const newContent = content.split(search_string).join(replace_string);
      fs.writeFileSync(fullPath, newContent, 'utf-8');
      return { status: 'success', message: `Replaced occurrences of '${search_string}' with '${replace_string}' in ${filepath}.` };
    } catch (error: any) {
      return { status: 'error', message: error.message };
    }
  },
});
