import { LlmAgent } from '@google/adk';
import { listFilesTool, readFileTool, writeFileTool } from './tools.js';
import * as dotenv from 'dotenv';

dotenv.config();

export const fileAgent = new LlmAgent({
  name: 'file_agent',
  model: 'gemini-2.0-flash-exp',
  description: 'An agent that can manage files in a sandbox directory.',
  instruction: `You are a helpful assistant capable of managing files.
  You are operating within a sandbox environment.
  You can list files, read files, and write files.
  Always verify your actions.`,
  tools: [listFilesTool, readFileTool, writeFileTool],
});
