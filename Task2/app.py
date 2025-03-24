import os
import tkinter as tk
from tkinter import scrolledtext
from PIL import Image, ImageTk
from openai import OpenAI
from dotenv import load_dotenv

# Load environment variables
load_dotenv()
api_key = os.environ["API_KEY"]

# Initialize OpenAI client
client = OpenAI(
    base_url="https://models.inference.ai.azure.com",
    api_key=api_key,
)

# Product details with image paths
title = "AI Sales Agent - Tech Store"
products = {
    "iPhone 13": {
        "price": 799,
        "features": "Great camera, fast processor, 128GB storage",
        "color": "Midnight Black",
        "stock": 15,
        "image": "data/iPhone_13.jpg"
    },
    "Samsung Galaxy S23": {
        "price": 699,
        "features": "Big screen, long battery, 5G support",
        "color": "Phantom Gray",
        "stock": 10,
        "image": "data/Samsung_Galaxy_S23.png"
    },
    "Google Pixel 7": {
        "price": 599,
        "features": "Best photos, pure Android, AI features",
        "color": "Obsidian",
        "stock": 8,
        "image": "data/Google_Pixel_7.jpg"
    }
}

# Global variable to hold the image reference (prevents garbage collection)
current_image = None

def get_sales_response(user_input):
    """Get AI-generated response and check for phone-specific requests."""
    prompt = f"""
    You are a friendly and enthusiastic AI Sales Agent for a phone store. Your goals are to:
    - Answer questions about phones with detailed and accurate info.
    - Recommend phones based on user needs or preferences (e.g., budget, camera quality, battery life).
    - Assist with sales, including checking availability and guiding orders.
    - If the user asks about a product not in the catalog, say something like, "Sorry, we don’t carry that phone, but I can suggest something similar!"
    - If the user only asks to 'see' or 'show' a phone or about its appearance, include '[SHOW_IMAGE: phone_name]' in your response.

    Here’s the phone catalog:
    - iPhone 13: ${products['iPhone 13']['price']}, {products['iPhone 13']['features']}, Color: {products['iPhone 13']['color']}, Stock: {products['iPhone 13']['stock']} units
    - Samsung Galaxy S23: ${products['Samsung Galaxy S23']['price']}, {products['Samsung Galaxy S23']['features']}, Color: {products['Samsung Galaxy S23']['color']}, Stock: {products['Samsung Galaxy S23']['stock']} units
    - Google Pixel 7: ${products['Google Pixel 7']['price']}, {products['Google Pixel 7']['features']}, Color: {products['Google Pixel 7']['color']}, Stock: {products['Google Pixel 7']['stock']} units

    User says: "{user_input}"
    Respond in a natural, conversational tone. Be proactive—offer extra info, suggest alternatives, or confirm stock if relevant. Keep it concise but helpful!
    """
    response = client.chat.completions.create(
        messages=[
            {"role": "system", "content": "You are a helpful sales agent."},
            {"role": "user", "content": prompt}
        ],
        model="gpt-4o",
        temperature=1,
        max_tokens=300,
    )
    return response.choices[0].message.content.strip()

def show_image(phone_name):
    """Display the image of the specified phone."""
    global current_image
    if phone_name in products and os.path.exists(products[phone_name]["image"]):
        img = Image.open(products[phone_name]["image"])
        img = img.resize((200, 200), Image.Resampling.LANCZOS)  # Resize for display
        current_image = ImageTk.PhotoImage(img)
        image_label.config(image=current_image)
    else:
        image_label.config(image="", text="Image not available.")

def send_message():
    """Handles user input, AI response, and image display."""
    user_text = entry.get()
    if not user_text.strip():
        return
    chat_window.insert(tk.END, f"You: {user_text}\n", "user")
    entry.delete(0, tk.END)
    try:
        response = get_sales_response(user_text)
        chat_window.insert(tk.END, f"Agent: {response}\n", "agent")
        # Check for image display request
        for phone in products.keys():
            if f"[SHOW_IMAGE: {phone}]" in response:
                show_image(phone)
                break
        else:
            image_label.config(image="", text="")  # Clear image if no match
    except Exception as e:
        chat_window.insert(tk.END, "Agent: Oops, something went wrong!\n", "error")

def clear_chat():
    """Clears the chat window and image."""
    chat_window.delete(1.0, tk.END)
    image_label.config(image="", text="")

# GUI Setup
root = tk.Tk()
root.title(title)
root.geometry("500x700")  # Increased height for image
root.configure(bg="#f4f4f4")

# Chat Window
chat_window = scrolledtext.ScrolledText(root, wrap=tk.WORD, bg="white", font=("Arial", 12), height=20)
chat_window.pack(padx=10, pady=10, fill=tk.BOTH, expand=True)
chat_window.tag_config("user", foreground="blue", font=("Arial", 12, "bold"))
chat_window.tag_config("agent", foreground="green", font=("Arial", 12))
chat_window.tag_config("error", foreground="red", font=("Arial", 12, "italic"))

# Image Display Area
image_label = tk.Label(root, bg="#f4f4f4")
image_label.pack(pady=5)

# Input Field
entry_frame = tk.Frame(root, bg="#f4f4f4")
entry_frame.pack(padx=10, pady=5, fill=tk.X)
entry = tk.Entry(entry_frame, font=("Arial", 12))
entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=5)

# Buttons
send_button = tk.Button(entry_frame, text="Send", command=send_message, bg="#4CAF50", fg="white",
                        font=("Arial", 12, "bold"))
send_button.pack(side=tk.RIGHT, padx=5)
clear_button = tk.Button(root, text="Clear Chat", command=clear_chat, bg="#FF5733", fg="white",
                         font=("Arial", 12, "bold"))
clear_button.pack(pady=5)

root.mainloop()