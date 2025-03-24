# Import necessary libraries
import tensorflow as tf
import numpy as np
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from flask import Flask, request, jsonify
import io  # For BytesIO
import matplotlib.pyplot as plt

# Initialize Flask app
app = Flask(__name__)

# Load the trained model from the .keras file
model = tf.keras.models.load_model('pneumonia_detection_model2.keras')
print("Model loaded successfully!")


# Function to preprocess the image
def preprocess_image(image_file):
    # Convert FileStorage to BytesIO
    img_bytes = io.BytesIO(image_file.read())
    # Load the image from BytesIO with target size 224x224
    img = load_img(img_bytes, target_size=(224, 224))
    # Convert image to array
    img_array = img_to_array(img)
    # Normalize pixel values to 0-1
    img_array = img_array / 255.0
    # Add batch dimension (model expects shape: (1, 224, 224, 3))
    img_array = np.expand_dims(img_array, axis=0)
    return img_array


# Define API endpoint for prediction
@app.route('/predict', methods=['POST'])
def predict():
    # Check if an image file is in the request
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    # Get the image file from the request
    image_file = request.files['image']

    try:
        # Preprocess the image
        processed_image = preprocess_image(image_file)

        # Make prediction
        prediction = model.predict(processed_image)
        prediction_value = prediction[0][0]  # Get the probability (0 to 1)

        # Interpret the result
        result = 'Pneumonia' if prediction_value > 0.5 else 'Normal'

        # Return the prediction as JSON
        return jsonify({
            'prediction': result,
            'confidence_score': float(prediction_value)  # Convert to float for JSON
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500


# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)