import { fileAgent } from './agent.js';
import { InMemoryRunner } from '@google/adk';

async function main() {
  // Use the command line argument as the prompt, or a default one that tests the new tool
  const prompt = process.argv[2] || "Create a file named 'test.txt' with the content 'The quick brown fox'. Then, replace 'fox' with 'dog'. Verify the content of the file.";
  console.log(`Running agent with prompt: "${prompt}"`);

  const runner = new InMemoryRunner({
    agent: fileAgent,
    appName: 'file-agent-runner',
  });

  try {
    const session = await runner.sessionService.createSession({
      appName: 'file-agent-runner',
      userId: 'test-user',
    });

    const generator = runner.runAsync({
      userId: 'test-user',
      sessionId: session.id,
      newMessage: { role: 'user', parts: [{ text: prompt }] },
    });

    for await (const event of generator) {
      if (event.type === 'model_response') {
          const response = event.response;
           if (response && response.content && response.content.parts) {
               for(const part of response.content.parts) {
                   if (part.text) {
                       console.log("Agent response:", part.text);
                   }
               }
           }
      }
    }
  } catch (error) {
    console.error("Error running agent:", error);
  }
}

main();
