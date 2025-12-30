Summary: Updated the minimal LLM implementation to use random seeds, refactored generation code, and added a demo with random starting words.

# User Prompt
use random random seed. refactor code to reduce duplication, especially when generating for prompts. and generate for 10 more random starting words, 30% are in words in the training data.

# Agent Response
I modified `codes/minimal_llm/main.cpp` to use `std::random_device` and `time(NULL)` for seeding, ensuring random initialization across runs. I refactored the text generation logic into a `generate_text` helper function to reduce code duplication. I also implemented logic to randomly select 10 starting words (3 from the training data and 7 from a predefined list of other words) and generate text for them. I updated `codes/minimal_llm/README.md` with the new output showing these random generations.
