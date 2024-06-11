import os, shutil, requests, time
from threading import Thread
from roboflow import Roboflow
from werkzeug.utils import secure_filename
from flask import Flask, request, jsonify
#**************************************
#   CONFIG
#*************************************
API_KEY = "2b10pBTi7LFZ2zKYWkvYXpMae"
ALLOWED_EXTENSIONS = ('.png', '.jpg', '.jpeg') # Only a tuple, Don't forget '.' before extension
UPLOAD_FOLDER = 'images' # WARNING : This folder will be delete, choose a empty folder

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['ALLOWED_EXTENSIONS'] = ALLOWED_EXTENSIONS

results_data = []  # List to shared data between Thread and caller



def image_recognition(type: str, request : request)-> list[dict, ...]:
    '''
    Recognize the specie of type of living being in image
    Take a Flask request with file and return a dict.
    
    :param type: 'plant' or 'bird' 
    :param request: flask resquest with files and KEY = 'image'
    :return: Empty list if can't recognize (Maybe you set wrong type) else a list of dict
    '''
    try:
        global results_data
        results_data = [] # Clean result, use for Thread share result
        imagefile = request.files['image']# Get image from Post
        
        if imagefile.filename == '':
            return {"error": "No selected file"}

        if not imagefile.filename.lower().endswith(app.config['ALLOWED_EXTENSIONS']):
            return {"error" : "Extension file not allowed"}

        filename = secure_filename(imagefile.filename) 
        imagefile.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

        # Select Recognition way
        match type:
            case 'plant':
                recognition = Thread(target=plant_recognition)
            case 'bird':
                recognition = Thread(target=bird_recognition, args=[os.path.join(app.config['UPLOAD_FOLDER'],filename)])
            case _:
                return {"error" : "Type not found"}
        
        recognition.start(), # start recognition
        recognition.join() # Wait recognition

        # Delete images
        shutil.rmtree(path=app.config['UPLOAD_FOLDER'], ignore_errors=True)
        os.mkdir(app.config['UPLOAD_FOLDER'])
        
        return results_data

    except KeyError:
        return {"error": "No file part"}
    except FileNotFoundError:
        if not os.path.isdir(app.config['UPLOAD_FOLDER']):
            os.mkdir(app.config['UPLOAD_FOLDER'])
        return {"error" : "implementation skill issue, Please retry. If retry not work, please contact a developer"}
    except Exception as error:
        app.logger.error(error)
        return {"error" : "Internal Error or Exception not implemented"}

@app.route('/upload', methods=["POST"])
def upload_plant():
    return jsonify({
        "message": "Image uploaded successfully",
        "results": image_recognition(type='plant', request= request)
    })

@app.route('/bird_recognition', methods=["POST"])  
def upload_bird():
    return jsonify({
        "message": "Bird image uploaded successfully",
        "results": image_recognition(type='bird', request= request)  # Include the results in the response
    })

def plant_recognition():
    global results_data
    processed_images = False
    folder_path = "images"
    api_endpoint = f"https://my-api.plantnet.org/v2/identify/all?api-key={API_KEY}"
    image_paths = [os.path.join(folder_path, f) for f in os.listdir(folder_path) if f.endswith(('.jpeg', '.jpg', '.png', '.bmp', '.webp'))]

    if len(image_paths) == 0:
        results_data.append({"error": "No images were found in the folder."})
        exit()

    results = []
    for image_path in image_paths:
        with open(image_path, 'rb') as image_file:
            files = {'images': image_file}
            response = requests.post(api_endpoint, files=files)
            json_result = response.json()
            results.append(json_result)
    # Check if results list is not empty
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
                finally:
                    results_data.append({
                        "scientific_name": scientific_name,
                        "score": score,
                    })
def bird_recognition(image_path : str):
    global results_data
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

    # Construct the result
    results_data = {
        "confidence": confidence,
        "class_name": class_name,
        "predicted_image_path": prediction_path
    }

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=4000)