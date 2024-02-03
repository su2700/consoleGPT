#!/bin/bash

# Set your OpenAI API key here
API_KEY="API-KEY"

# API endpoint
API_ENDPOINT="https://api.openai.com/v1/chat/completions"

# Function to send a message to ChatGPT
function send_message() {
  local message="$1"
  curl -s -X POST "$API_ENDPOINT" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content": "'"$message"'"
        }
      ],
      "max_tokens": 50
    }'
}

# Interactive chat loop
while true; do
  read -p "You: " user_input
  if [[ "$user_input" == "quit" ]]; then
    echo "ChatGPT: Goodbye!"
    break
  fi

  response=$(send_message "$user_input")

  chatgpt_reply=$(echo "$response" | jq -r '.choices[0].message.content')

  echo "ChatGPT: $chatgpt_reply"
done
