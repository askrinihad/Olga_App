from flask import Flask, request, jsonify
import werkzeug
import os
import requests
import time
from threading import Thread
from roboflow import Roboflow
from werkzeug.utils import secure_filename

app = Flask(__name__)

API_KEY = "2b10pBTi7LFZ2zKYWkvYXpMae"
results_data = []  
bird_result =[]# A list to store the results
UPLOAD_FOLDER = 'birds'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/upload', methods=["POST"])
def upload():
    global processed_images  # Use the global variable
    if request.method == "POST":
        imagefile = request.files['image']
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        imagefile.save("./images/" + filename)

        # Starting a new thread to run the predict function
        Thread(target=predict).start()
        time.sleep(3) 
        return jsonify({
            "message": "Image uploaded successfully",
            "results": results_data  # Include the results in the response
        })

def predict():
    did=True
    global results_data, processed_images 
    results_data = []
    processed_images = False  # Use the global variables
    folder_path = "images"
    api_endpoint = f"https://my-api.plantnet.org/v2/identify/all?api-key={API_KEY}"
    image_paths = [os.path.join(folder_path, f) for f in os.listdir(folder_path) if f.endswith(('.jpeg', '.jpg', '.png', '.bmp', '.webp'))]

    if len(image_paths) == 0:
        print("No images were found in the folder.")
        exit()

    results = []

    # Process each image file only if images have not been processed yet
    if not processed_images:
        for image_path in image_paths:
            with open(image_path, 'rb') as image_file:
                files = {'images': image_file}
                response = requests.post(api_endpoint, files=files)
                json_result = response.json()
                results.append(json_result)
                print(json_result)

             # Delay for 3 seconds between each image processing

            # Delete the processed image file
            try:
                os.remove(image_path)
                print(f"Deleted image: {image_path}")
            except Exception as e:
                print(f"Error deleting image {image_path}: {e}")

        # Set the flag to indicate that images have been processed
        processed_images = True

    for i, result in enumerate(results):
        image_path = image_paths[i]
        for r in result.get('results', []):
            try:
                scientific_name = r['species']['scientificName']
                score = r['score']
                common_names = ', '.join(r['species']['commonNames'])
            except KeyError:
                scientific_name = 'Unavailable'
                score = 'Unavailable'
                common_names = 'Unavailable'
          
            if(did==True):
                print("scientific name", scientific_name)
                print("score:", score)
                did=False
                results_data.append({
                "scientific_name": scientific_name,
                "score": score,
                })

@app.route('/bird_recognition', methods=["POST"])  
def upload_bird():
    if 'image' not in request.files:
        return jsonify({"error": "No file part"})

    file = request.files['image']

    if file.filename == '':
        return jsonify({"error": "No selected file"})

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)

        # Starting a new thread to run the bird_recognition function
        Thread(target=bird_recognition, args=(file_path,)).start()
        time.sleep(3) 
        return jsonify({
            "message": "Bird image uploaded successfully",
            "results": bird_result  # Include the results in the response
        })

    return jsonify({"error": "Invalid file type"})

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def bird_recognition(image_path):
        global bird_result
        rf = Roboflow(api_key="zil5scCJofh6YkIUGFAO")
        project = rf.workspace().project("bird-v2")
        model = project.version(2).model
        prediction = model.predict(image_path, confidence=40, overlap=30)
        prediction_path = os.path.join(app.config['UPLOAD_FOLDER'], 'prediction.jpg')
        prediction.save(prediction_path)

        # Convert prediction to JSON
        prediction_json = prediction.json()
        predictions = prediction_json.get('predictions', [])
        for prediction in predictions:
            confidence = prediction.get('confidence', None)
            class_name = prediction.get('class', None)
            if confidence is not None and class_name is not None:
                print(f"Confidence: {confidence}, Class: {class_name}")

        # Construct the result
        bird_result = {
            "confidence": confidence,
            "class_name": class_name,
            "predicted_image_path": prediction_path
        }

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=4000)
