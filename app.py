from flask import Flask, request, jsonify
from onnx_qa_model import Onnx_qa_model

app = Flask(__name__)

@app.route('/gen_a', methods=['POST'])
def evaluate():
    data = request.get_json()
    question = data['question']
    context = data['context']
    
    # Call the get_evaluation method of the Eval_model instance
    result = Onnx_qa_model.get_answer(question, context)
    return jsonify(result)

@app.route('/', methods=['GET'])
def home():
    # Call the get_evaluation method of the Eval_model instance
    result = Onnx_qa_model.get_answer('What is Ahmed Bilal trying?', 'Ahmed Bilal has been lately trying his best.')
    return jsonify(result)

if __name__ == '__main__':

    # model_path = './models/transformers/' 
    # model = AutoModelForSequenceClassification.from_pretrained(model_path, local_files_only=True)
    # print("----------- transformer model loaded ------------")
    # tokenizer = AutoTokenizer.from_pretrained(model_path, local_files_only=True)
    # print("----------- transformer tokenizer loaded ------------")
    # classifier = pipeline('sentiment-analysis', model=model, tokenizer=tokenizer)
    # print(classifier)

    app.run(debug=True, host='0.0.0.0')

